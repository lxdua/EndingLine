extends Node2D
class_name RouteSelectionScene

const STATION: = preload("res://Scene/RouteSelectionScene/Station/station.tscn")
const TRACK: = preload("res://Scene/RouteSelectionScene/Track/track.tscn")
const BUILDABLE_TRACK = preload("res://Scene/RouteSelectionScene/Track/buildable_track.tscn")

const MAX_STATION_NUM: = 500
const MAX_TRACK_LENGTH: = INF

@export var train_stats_manager: TrainStatsManager

@export var map_res: MapRes

@export var track_root: Node2D
@export var station_root: Node2D
@export var train_in_map: Node2D

func _ready() -> void:
	init_floyd()
	create_map()
	init_train()
	hide_station_content()

#region 地图相关

## 存站台
var station_dict: Dictionary
## 站台下标统计
var idx: int = 0

#region 地图相关-生成相关

func create_map():
	# 放车站
	var station_pos_list = map_res.station_pos_list
	for pos in station_pos_list:
		add_station(pos)
	# 放路
	var track_list = map_res.track_list
	for track in track_list:
		add_track(station_dict[track.x], station_dict[track.y], track.z)
	# 放没修建的路
	var buildable_track_list = map_res.buildable_track_list
	for track in buildable_track_list:
		add_buildable_track(station_dict[track.x], station_dict[track.y], track.z)
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

func remove_station(station: Station): # TODO 别忘了还要废掉周围的路
	station_dict.erase(station.station_id)
	station.queue_free()

func add_track(start_station: Station, end_station: Station, track_length: int):
	var new_track: = TRACK.instantiate()
	new_track.start_station = start_station
	new_track.end_station = end_station
	new_track.track_length = track_length
	track_root.add_child(new_track)
	start_station.station_connected_track.append(new_track)
	end_station.station_connected_track.append(new_track)
	update_track(start_station, end_station, track_length)

func add_buildable_track(start_station: Station, end_station: Station, track_length: int):
	var new_buildable_track: = BUILDABLE_TRACK.instantiate()
	new_buildable_track.start_station = start_station
	new_buildable_track.end_station = end_station
	new_buildable_track.track_length = track_length
	track_root.add_child(new_buildable_track)

func remove_track(track: Track):
	track.queue_free()
	update_track(track.start_station, track.end_station, MAX_TRACK_LENGTH)

func update_track(start_station: Station, end_station: Station, track_length: int):
	matrix[start_station.station_id][end_station.station_id] = min(matrix[start_station.station_id][end_station.station_id], track_length)
	update_floyd(start_station.station_id)
	update_floyd(end_station.station_id)

#endregion

#region 地图相关-最短路相关

## 邻接矩阵
var matrix: Array[Array]
## 最短路途径点
var mid_station: Array[Array]
## 最短路
var shortest_path: Array[int] = []

func init_floyd(n: int = MAX_STATION_NUM):
	matrix.clear()
	for i in range(n):
		matrix.append([])
		mid_station.append([])
		for j in range(n):
			matrix[i].append(MAX_TRACK_LENGTH)
			mid_station[i].append(-1)
	for i in range(n):
		matrix[i][i] = 0

func update_floyd(k: int, n: int = MAX_STATION_NUM):
	for x in range(n):
		for y in range(n):
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
	buildable_track.queue_free()

#endregion


#endregion

#region 列车相关

## 目标点
var destination_id: int:
	set(v):
		destination_id = v
		destination_id_update.emit(v)
		print("新终点为", v)

signal destination_id_update(id: int)

var current_station_id: int

## 下一站清单
var route_list: Array[int]

func init_train():
	train_in_map.global_position = station_dict[0].station_position
	current_station_id = 0

var is_driving: bool = false

func drive():
	if matrix[current_station_id][destination_id] == INF:
		print("无法到达！")
		return

	route_list = get_shortest_path(station_dict[current_station_id], station_dict[destination_id])
	if is_driving:
		print("更换目的地！")
	else:
		print("出发！")
		is_driving = true
		while not route_list.is_empty():
			var next_station_id: int = route_list.pop_front()
			print("正在前往", next_station_id)
			var drive_tween = train_in_map.create_tween()
			drive_tween.tween_property(
				train_in_map,
				"global_position",
				station_dict[next_station_id].station_position,
				matrix[current_station_id][next_station_id] / 5.0,
				) #TODO 速度相关
			await drive_tween.finished
			current_station_id = next_station_id
		is_driving = false

#endregion

#region UI交互

@onready var map: CanvasLayer = $Map
@onready var ui: CanvasLayer = $UI
@onready var station_content_container: PanelContainer = $UI/StationContentContainer


func show_all():
	map.show()
	ui.show()

func hide_all():
	map.hide()
	ui.hide()

## 确认出发
func _on_set_sail_button_pressed() -> void:
	hide_station_content()
	drive()

func _on_close_button_pressed() -> void:
	hide_station_content()
	hide_all()
	print("关闭")

func _on_destination_id_update(id: int) -> void:
	show_station_content() # TODO 等城市节点

func show_station_content(): # TODO 等城市节点
	station_content_container.update_content(
		station_dict[destination_id],
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

func _on_speed_up_button_button_down() -> void:
	Engine.set_time_scale(2.0)

func _on_speed_up_button_button_up() -> void:
	Engine.set_time_scale(1.0)

#endregion
