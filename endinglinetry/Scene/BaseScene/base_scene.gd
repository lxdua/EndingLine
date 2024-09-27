extends Node2D
class_name BaseScene


func _ready() -> void:
	hide_all_secondary_scene()

#region 列车属性相关

@export var train_stats_manager: Node

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
