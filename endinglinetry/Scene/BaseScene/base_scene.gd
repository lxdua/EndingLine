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
