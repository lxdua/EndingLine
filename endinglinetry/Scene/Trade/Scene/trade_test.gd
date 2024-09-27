extends Node2D

@onready var fog: Fog = $Fog


func _on_sprite_2d_pressed() -> void:
	if fog.is_in_light(get_global_mouse_position()):
		print("按下")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			if event.pressed:
				fog.add_light_point(get_global_mouse_position())
