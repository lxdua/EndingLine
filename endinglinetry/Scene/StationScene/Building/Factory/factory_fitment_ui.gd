extends Button
class_name FactoryFitmentUI

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var card_front: Sprite2D
@export var content_label: Label
@export var name_label: Label
@export var border: Sprite2D

var fitment: Fitment = null

func update_fitment(new_fitment: Fitment):
	fitment = new_fitment
	name_label.text = fitment.fitment_name
	#card_front.texture = fitment.icon
	content_label.text = fitment.fitment_content

signal factory_fitment_button_pressed(fitment_name: String)

func _on_pressed() -> void:
	factory_fitment_button_pressed.emit(fitment.fitment_name)
	print("fitment!")

func _on_mouse_entered() -> void:
	animation_player.play("card flip")
	border.material.set_shader_parameter("outline_width", 1)

func _on_mouse_exited() -> void:
	animation_player.play_backwards("card flip")
	border.material.set_shader_parameter("outline_width", 0)
