extends Node3D

@onready var camera_spring_arm: SpringArm3D = get_tree().get_first_node_in_group("CameraSpringArm")

var opacity: float

func _process(delta: float) -> void:
	opacity = clamp(remap(camera_spring_arm.spring_length, 10.0, 15.0, 0.0, 1.0), 0.0, 1.0)
	RenderingServer.global_shader_parameter_set("opacity", opacity)
