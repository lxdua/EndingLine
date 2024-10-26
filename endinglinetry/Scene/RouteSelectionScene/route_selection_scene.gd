extends Node2D
class_name RouteSelectionScene

const STATION: = preload("res://Scene/RouteSelectionScene/Station/station.tscn")
const TRACK: = preload("res://Scene/RouteSelectionScene/Track/track.tscn")
const BUILDABLE_TRACK = preload("res://Scene/RouteSelectionScene/Track/buildable_track.tscn")

const MAX_TRACK_LENGTH: = INF

@export var seed_str: String
@export var station_num: int = 20

@export var base_scene: BaseScene
@export var train_stats_manager: TrainStatsManager

@export var track_root: Node2D
@export var station_root: Node2D
@export var train_in_map: Node2D

var map_res: MapRes

func _ready() -> void:
	GlobalVar.time_scale_update.connect(_on_time_scale_update)
	create_map()
	floyd()
	init_train()
	hide_station_content()

func _physics_process(delta: float) -> void:
	camera_follow_train(delta)
	calc_journey(delta)

func _process(delta: float) -> void:
	update_hight_light_line()
	drag_carema()

func _unhandled_input(event: InputEvent) -> void:
	camera_zoom(event)
	drag_camera(event)

#region 地图相关

## 存站台
var station_dict: Dictionary
## 站台下标统计
var idx: int = 0

#region 地图相关-生成相关

func create_map():
	var random_map_maker: RandomMapMaker = RandomMapMaker.new()
	map_res = random_map_maker.make_random_map(station_num, seed_str)
	# 放车站
	var station_pos_list = map_res.station_pos_list
	for pos in station_pos_list:
		add_station(pos)
	# 放路
	var track_list = map_res.track_list
	for track in track_list:
		add_track(station_dict[track[0]], station_dict[track[1]], track[2])
	# 放没修建的路
	var buildable_track_list = map_res.buildable_track_list
	for track in buildable_track_list:
		add_buildable_track(station_dict[track[0]], station_dict[track[1]], track[2], track[3])
	# 部署车站
	for station_id in station_dict:
		station_dict[station_id].deploy_station()

func add_station(station_position: Vector2):
	var new_station: = STATION.instantiate()
	new_station.station_id = idx
	new_station.station_position = station_position
	station_dict[idx] = new_station
	station_root.add_child(new_station)
	idx += 1

func add_track(start_station: Station, end_station: Station, track_length: int):
	var new_track: = TRACK.instantiate()
	new_track.start_station = start_station
	new_track.end_station = end_station
	new_track.track_length = track_length
	track_root.add_child(new_track)
	start_station.station_connected_track.append(new_track)
	end_station.station_connected_track.append(new_track)

func add_buildable_track(start_station: Station, end_station: Station, track_length: int, cost: int):
	var new_buildable_track: = BUILDABLE_TRACK.instantiate()
	new_buildable_track.start_station = start_station
	new_buildable_track.end_station = end_station
	new_buildable_track.track_length = track_length
	new_buildable_track.cost = cost
	track_root.add_child(new_buildable_track)

#endregion

#region 地图相关-最短路相关

## 邻接矩阵
var matrix: Array[Array]
## 最短路途径点
var mid_station: Array[Array]
## 最短路
var shortest_path: Array[int] = []

func floyd():
	matrix.clear()
	for i in range(station_num):
		matrix.append([])
		mid_station.append([])
		for j in range(station_num):
			matrix[i].append(MAX_TRACK_LENGTH)
			mid_station[i].append(-1)
	for i in range(station_num):
		matrix[i][i] = 0

	var track_list = map_res.track_list
	for track in track_list:
		matrix[track[0]][track[1]] = track[2]

	for k in range(station_num):
		for x in range(station_num):
			for y in range(station_num):
				if matrix[x][y] > matrix[x][k] + matrix[k][y]:
					matrix[x][y] = matrix[x][k] + matrix[k][y]
					mid_station[x][y] = k

func update_floyd(u: int, v: int, dist: float):
	matrix[u][v] = min(matrix[u][v], dist)
	matrix[v][u] = min(matrix[v][u], dist)
	for k in range(station_num):
		for x in range(station_num):
			for y in range(station_num):
				if matrix[x][y] > matrix[x][k] + matrix[k][y]:
					matrix[x][y] = matrix[x][k] + matrix[k][y]
					mid_station[x][y] = k

func get_shortest_path(start_station: Station, end_station: Station):
	shortest_path.clear()
	calc_mid(start_station.station_id, end_station.station_id)
	return shortest_path

func calc_mid(x: int, y: int):
	if x == y:
		return
	var k = mid_station[x][y]
	if k == -1:
		shortest_path.append(y)
	else:
		prints(x, k, y)
		calc_mid(x, k)
		calc_mid(k, y)

#endregion

#region 地图相关-建造相关

func try_to_build_track(buildable_track: BuildableTrack):
	var whether_ui = GlobalUiBox.WHETHER_UI.instantiate()
	whether_ui.content = "建造道路\n" + "需要" + str(buildable_track.cost) + "钱\n" + "确定建造吗"
	whether_ui.can_press_yes = train_stats_manager.has_money(buildable_track.cost)
	ui.add_child(whether_ui)
	await whether_ui.finish
	if whether_ui.result == true:
		build_track(buildable_track)

func build_track(buildable_track: BuildableTrack):
	train_stats_manager.current_money -= buildable_track.cost
	add_track(buildable_track.start_station, buildable_track.end_station, buildable_track.track_length)
	map_res.track_list.append([buildable_track.start_station.station_id, buildable_track.end_station.station_id, buildable_track.track_length])
	add_track(buildable_track.end_station, buildable_track.start_station, buildable_track.track_length)
	map_res.track_list.append([buildable_track.end_station.station_id, buildable_track.start_station.station_id, buildable_track.track_length])
	buildable_track.queue_free()
	prints("建造了联通", buildable_track.start_station, buildable_track.end_station, "的路！")
	floyd()
	#update_floyd(buildable_track.start_station.station_id, buildable_track.end_station.station_id, buildable_track.track_length)

#endregion


#endregion

#region 列车相关

@onready var hight_light_line: Line2D = $Map/HightLightLine

## 目标点
var destination_id: int:
	set(v):
		destination_id = v
		destination_id_update.emit(v)
		print("新终点为", v)

signal destination_id_update(id: int)
signal set_out(station: Station)
signal arrive(station_scene: StationScene)

var current_station_id: int
var next_station_id: int

var drive_tween: Tween

## 下一站清单
var route_list: Array[int]

func init_train():
	# TODO 起点
	current_station_id = idx - 2
	next_station_id = current_station_id
	train_in_map.global_position = station_dict[current_station_id].station_position

var is_driving: bool:
	set(v):
		train_stats_manager.is_driving = v
	get:
		return train_stats_manager.is_driving

func drive():
	if matrix[current_station_id][destination_id] == INF:
		print("无法到达！")
		return

	route_list = get_shortest_path(station_dict[current_station_id], station_dict[destination_id])

	if is_driving:
		print("更换目的地！")
	elif destination_id == current_station_id:
		print("已经到达！")
	else:
		print("出发！", route_list)
		is_driving = true
		set_out.emit(station_dict[current_station_id])
		await CurtainLayer.curtain_animation_player.animation_finished # 等黑屏

		while not route_list.is_empty():
			next_station_id = route_list.pop_front()
			print("正在前往", next_station_id)
			drive_tween = train_in_map.create_tween()
			drive_tween.set_speed_scale(GlobalVar.time_scale)
			drive_tween.tween_property(
				train_in_map,
				"global_position",
				station_dict[next_station_id].station_position,
				matrix[current_station_id][next_station_id] / train_stats_manager.current_speed,
				)
			await drive_tween.finished
			current_station_id = next_station_id

		is_driving = false
		arrive.emit(station_dict[current_station_id].station_scene)

func update_hight_light_line():
	hight_light_line.clear_points()
	hight_light_line.add_point(train_in_map.global_position)
	hight_light_line.add_point(station_dict[next_station_id].station_position)
	for id in route_list:
		hight_light_line.add_point(station_dict[id].station_position)

func calc_journey(delta: float):
	train_stats_manager.total_journey += delta * train_stats_manager.current_speed

#endregion

#region UI交互

@onready var map: CanvasLayer = $Map
@onready var ui: CanvasLayer = $UI
@onready var station_content_container: PanelContainer = $UI/StationContentContainer

var all_visible: bool:
	set(v):
		all_visible = v
		if all_visible:
			map.show()
			ui.show()
			can_drag = true
		else:
			map.hide()
			ui.hide()
			can_drag = false


## 确认出发
func _on_set_sail_button_pressed() -> void:
	hide_station_content()
	drive()

## 取消出发
func _on_donot_set_sail_button_pressed() -> void:
	station_content_container.hide()

#region UI交互 - 关闭按钮

@onready var close_button_animated_sprite: AnimatedSprite2D = $UI/CloseButton/CloseButtonAnimatedSprite

func _on_close_button_pressed() -> void:
	hide_station_content()
	all_visible = false
	base_scene.hide_all_secondary_scene()

func _on_close_button_mouse_entered() -> void:
	close_button_animated_sprite.play("normal")
func _on_close_button_mouse_exited() -> void:
	close_button_animated_sprite.play_backwards("normal")


#endregion

func _on_destination_id_update(id: int) -> void:
	show_station_content()

func show_station_content():
	prints(destination_id, station_dict[destination_id].station_scene, matrix[current_station_id][destination_id])
	station_content_container.update_content(
		station_dict[destination_id].station_scene,
		matrix[current_station_id][destination_id]
		)
	station_content_container.show()

func hide_station_content():
	station_content_container.hide()

#endregion

#region 倍速相关

func _on_pause_button_pressed() -> void:
	get_tree().set_pause(true)

func _on_continue_button_pressed() -> void:
	get_tree().set_pause(false)

func _on_time_scale_update():
	if drive_tween != null:
		drive_tween.set_speed_scale(GlobalVar.time_scale)

func _on_speed_up_button_button_down() -> void:
	GlobalVar.time_scale = 100.0

func _on_speed_up_button_button_up() -> void:
	GlobalVar.time_scale = 1.0

#endregion

#region 摄像机相关

@onready var camera: Camera2D = $Map/Camera
@onready var marker: Marker2D = $UI/Marker

var can_drag: bool = false
var is_following: bool = true
var is_draging: bool = false

var mouse_pos: Vector2

func camera_follow_train(delta: float):
	if not all_visible:
		return
	if is_following:
		camera.global_position = lerp(camera.global_position, train_in_map.global_position, delta)

func drag_camera(event: InputEvent):
	if not can_drag:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_following = false
		mouse_pos = get_viewport().get_mouse_position()
		if event.is_pressed():
			is_draging = true
		else:
			is_draging = false

func drag_carema():
	if is_draging and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		camera.position -= (get_viewport().get_mouse_position() - mouse_pos) / camera.zoom.length()
		mouse_pos = get_viewport().get_mouse_position()
		camera.position_smoothing_enabled = false

func _on_follow_button_pressed() -> void:
	camera.global_position = train_in_map.global_position
	is_following = true
	camera.position_smoothing_enabled = true

func camera_zoom(event: InputEvent):
	if not all_visible:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if camera.zoom * 1.1 > Vector2(2.0,2.0):
				return
			camera.zoom *= 1.1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if camera.zoom / 1.1 < Vector2(0.5,0.5):
				return
			camera.zoom /= 1.1

#endregion
