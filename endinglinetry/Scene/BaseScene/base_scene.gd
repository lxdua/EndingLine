extends Node2D
class_name BaseScene


func _ready() -> void:
	hide_all_secondary_scene()
	update_clock_ui()


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
	Engine.set_time_scale(2.0)

func _on_speed_up_button_button_up() -> void:
	Engine.set_time_scale(1.0)

#endregion


#region 状态栏相关

@onready var train_load_label: Label = $UI/StatusBarContainer/HBoxContainer/TrainLoadLabel
@onready var train_speed_label: Label = $UI/StatusBarContainer/HBoxContainer/TrainSpeedLabel
@onready var power_progress_bar: TextureProgressBar = $UI/StatusBarContainer/HBoxContainer/PowerProgressBar


#endregion


#region 时间相关

@onready var date_label: Label = $UI/DateContainer/VBoxContainer/DateLabel
@onready var clock_label: Label = $UI/DateContainer/VBoxContainer/ClockLabel

## 总分钟
var current_time: int = 0

func update_clock_ui():
	var date = str(current_time / 1440)
	var clock = current_time % 1440
	var hour = int(clock / 60)
	var minute = clock % 60
	date_label.text = "第" + date + "天"
	if hour < 10:
		hour = "0" + str(hour)
	else:
		hour = str(hour)
	if minute < 10:
		minute = "0" + str(minute)
	else:
		minute = str(minute)
	clock_label.text = hour + ":" + minute

func _on_clock_timer_timeout() -> void:
	current_time += 10
	update_clock_ui()

#endregion
