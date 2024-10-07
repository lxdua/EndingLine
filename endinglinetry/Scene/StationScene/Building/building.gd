extends Node3D
class_name Building

@onready var building_sprite: Sprite3D = $BuildingSprite

func press_building():
	pass

func _on_building_area_mouse_entered() -> void:
	pass

func _on_building_area_mouse_exited() -> void:
	pass

func _on_building_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		press_building()
