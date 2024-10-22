extends SpringArm3D

@onready var camera: Camera3D = $Camera

var is_on: bool = true

var dist: float = 11:
	set(v):
		dist = clamp(v, 6.5, 40)

func _process(delta: float) -> void:
	spring_length = lerp(spring_length, dist, delta * 10.0)

var mouse_pos_x: float

func _on_vignette_color_rect_gui_input(event: InputEvent) -> void:
	if not is_on:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		mouse_pos_x = get_viewport().get_mouse_position().x
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var delta_x = get_viewport().get_mouse_position().x - mouse_pos_x
		mouse_pos_x = get_viewport().get_mouse_position().x
		position.x -= delta_x / 100
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			dist -= 1
			camera.size *= 0.9
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			dist += 1
			camera.size *= 1.1
