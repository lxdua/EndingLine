extends Node3D
class_name BaseScene


func _ready() -> void:
	hide_all_secondary_scene()
	current_time = start_time


#region 列车属性相关

@export var train_stats_manager: TrainStatsManager

#endregion


#region 二级界面相关

@export var secondary_scene_root: Node2D
@export var route_selection_scene: RouteSelectionScene

func hide_all_secondary_scene():
	for secondary_scene in secondary_scene_root.get_children():
		secondary_scene.hide_all()


func _on_goods_button_pressed() -> void:
	pass # Replace with function body.

func _on_train_information_button_pressed() -> void:
	pass # Replace with function body.

func _on_route_selection_button_pressed() -> void:
	route_selection_scene.show_all()

func _on_price_button_pressed() -> void:
	pass # Replace with function body.

func _on_build_button_pressed() -> void:
	pass # Replace with function body.

#endregion


#region 倍速相关

func _on_pause_button_pressed() -> void:
	get_tree().set_pause(true)

func _on_continue_button_pressed() -> void:
	get_tree().set_pause(false)

func _on_speed_up_button_button_down() -> void:
	Engine.set_time_scale(10.0)

func _on_speed_up_button_button_up() -> void:
	Engine.set_time_scale(1.0)

#endregion


#region 时间相关

@onready var date_label: Label = $UI/DateContainer/VBoxContainer/DateLabel
@onready var clock_label: Label = $UI/DateContainer/VBoxContainer/ClockLabel

var start_time: int = 5*60+30

## 总分钟
var current_time: int:
	set(v):
		current_time = v
		date = current_time / 1440
		clock = current_time % 1440
		hour = clock / 60
		minute = clock % 60
		update_clock_ui()

var date: int
var clock: int
var hour: int
var minute: int

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

func _on_clock_timer_timeout() -> void:
	current_time += 10

func is_daytime():
	return 6 <= hour and hour <= 18

#endregion
