extends Node3D

@onready var camera_spring_arm: SpringArm3D = get_tree().get_first_node_in_group("CameraSpringArm")

@onready var _4d: MeshInstance3D = $"34/4d"
@onready var _3d_1: MeshInstance3D = $"34/3d/3d1"
@onready var _3d_2: MeshInstance3D = $"34/3d/3d2"
@onready var _3d_3: MeshInstance3D = $"34/3d/3d3"

signal opacity_update
var opacity: float:
	set(v):
		opacity = v
		opacity_update.emit()

func _ready() -> void:
	camera_spring_arm.spring_len_update.connect(_on_spring_len_update)

func _on_spring_len_update(len: float):
	opacity = clamp(remap(len, 10.0, 15.0, 0.0, 1.0), 0.0, 1.0)

func _on_opacity_update() -> void:
	for i in _4d.mesh.get_surface_count():
		_4d.mesh.surface_get_material(i).set_shader_parameter("opacity", opacity)
	for i in _3d_1.mesh.get_surface_count():
		_3d_1.mesh.surface_get_material(i).set_shader_parameter("opacity", opacity)
	for i in _3d_2.mesh.get_surface_count():
		_3d_2.mesh.surface_get_material(i).set_shader_parameter("opacity", opacity)
	for i in _3d_3.mesh.get_surface_count():
		_3d_3.mesh.surface_get_material(i).set_shader_parameter("opacity", opacity)
