extends Node3D
class_name BaseScene

@export var train_stats_manager: TrainStatsManager
@export var trade_manager: TradeManage

func _ready() -> void:
	hide_all_secondary_scene()
	change_scene_to_station(get_current_station().station_scene)
	current_time = start_time

func _physics_process(delta: float) -> void:
	update_current_time(delta)
	update_sun(delta)

#region 场景相关

const TRAIN_SCENE = preload("res://Scene/TrainScene/train_scene.tscn")

@export var first_scene_root: Node3D
@export var parallax_bg: ParallaxBG
@export var camera_spring_arm: SpringArm3D

func get_current_station() -> Station:
	return route_selection_scene.station_dict[route_selection_scene.current_station_id]

func change_scene_to_station(station_scene: StationScene):
	for scene in first_scene_root.get_children():
		scene.queue_free()
	station_scene = station_scene.duplicate()
	check_portals(station_scene)
	first_scene_root.add_child(station_scene)
	parallax_bg.stop_scroll()

func change_scene_to_train():
	for scene in first_scene_root.get_children():
		scene.queue_free()
	var train_scene: = TRAIN_SCENE.instantiate()
	first_scene_root.add_child(train_scene)
	parallax_bg.start_scroll()

func arrive(station_scene: StationScene):
	GlobalVar.time_scale = 1.0
	await CurtainLayer.fade_in()
	hide_all_secondary_scene()
	time_scale_container.hide()
	change_scene_to_station(station_scene)
	await get_tree().create_timer(1.0).timeout
	await CurtainLayer.fade_out()
	# TODO 入站动画

func set_out():
	# TODO 出发动画
	await CurtainLayer.fade_in()
	hide_all_secondary_scene()
	time_scale_container.show()
	change_scene_to_train()
	await get_tree().create_timer(1.0).timeout
	await CurtainLayer.fade_out()

func check_portals(station_scene: StationScene):
	if get_current_station().station_id == route_selection_scene.idx - 1:
		station_scene.add_child(preload("res://Scene/StationScene/Building/Portals/portals.tscn").instantiate())

func _on_route_selection_scene_set_out(station: Station) -> void:
	set_out()

func _on_route_selection_scene_arrive(station_scene: StationScene) -> void:
	arrive(station_scene)

#endregion


#region 二级界面相关

@export var secondary_scene_root: CanvasLayer
@export var route_selection_scene: RouteSelectionScene
@export var train_stats_scene: TrainStatsScene
@export var fitment_scene: FitmentScene

func hide_all_secondary_scene():
	show()
	camera_spring_arm.is_on = true
	route_selection_scene.all_visible = false
	train_stats_scene.hide()
	fitment_scene.hide()

## 列车属性
func _on_under_button_ui_health_button_pressed() -> void:
	train_stats_scene.update_train_stats()
	train_stats_scene.show()
	camera_spring_arm.is_on = false

## 价格走势
func _on_under_button_ui_price_button_pressed() -> void:
	camera_spring_arm.is_on = false

## 路线选择
func _on_under_button_ui_route_selection_button_pressed() -> void:
	route_selection_scene.all_visible = true
	camera_spring_arm.is_on = false
	hide()

## 货物背包
func _on_under_button_ui_cargo_button_pressed() -> void:
	camera_spring_arm.is_on = false
	trade_manager.open_back_pack_ui()

## 遗物栏
func _on_under_button_ui_fitment_button_pressed() -> void:
	fitment_scene.show_scene()
	camera_spring_arm.is_on = false

#endregion


#region 倍速相关

@export var time_scale_container: Control

func _on_pause_button_pressed() -> void:
	get_tree().set_pause(true)

func _on_continue_button_pressed() -> void:
	get_tree().set_pause(false)

func _on_speed_up_button_button_down() -> void:
	GlobalVar.time_scale = 100.0

func _on_speed_up_button_button_up() -> void:
	GlobalVar.time_scale = 1.0

#endregion


#region 时间相关

@onready var date_label: Label = $UI/DateContainer/VBoxContainer/DateLabel
@onready var clock_label: Label = $UI/DateContainer/VBoxContainer/ClockLabel

@onready var sun_light: DirectionalLight3D = $SunLight

var start_time: int = 5*60+30

## 总分钟
var current_time: float:
	set(v):
		current_time = v
		date = current_time / 1440
		clock = int(current_time) % 1440
		hour = clock / 60
		minute = clock % 60
		update_clock_ui()

var date: int
var clock: int
var hour: int
var minute: int

func update_sun(delta: float):
	var sun_rot: = remap(clock/60.0-6, 0.0, 24.0, -180.0, 180.0)
	sun_light.rotation_degrees.x = lerp(sun_light.rotation_degrees.x, sun_rot, delta * GlobalVar.time_scale)

func update_clock_ui():
	date_label.text = "第" + str(date) + "天"
	clock_label.text = ""
	if hour < 10:
		clock_label.text += "0"
	clock_label.text += str(hour)
	clock_label.text += ":"
	if minute < 10:
		clock_label.text += "0"
	clock_label.text += str(minute)

func update_current_time(delta: float) -> void:
	current_time += 6 * delta * GlobalVar.time_scale

func is_daytime():
	return 6 <= hour and hour <= 18

#endregion
