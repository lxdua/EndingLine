extends Node2D
class_name BaseScene


func _ready() -> void:
	hide_all_secondary_scene()

#region 二级界面相关

@export var secondary_scene_root: Node2D
@export var route_selection_scene: RouteSelectionScene

func hide_all_secondary_scene():
	for secondary_scene in secondary_scene_root.get_children():
		secondary_scene.hide_all()

func _on_route_selection_button_pressed() -> void:
	route_selection_scene.show_all()

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
