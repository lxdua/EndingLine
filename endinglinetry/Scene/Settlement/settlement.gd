extends Control

@export_file("*.tscn") var prison_scene: String

@export var fitment_container: HFlowContainer
@export var coin_label: Label
@export var time_label: Label
@export var journey_label: Label

func back_to_prison():
	CurtainLayer.curtain_change_scene(prison_scene, "少女祈祷中。。。")


func _on_button_pressed() -> void:
	back_to_prison()
