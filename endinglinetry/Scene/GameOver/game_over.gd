extends Control

@export_file("*.tscn") var prison_scene: String

@onready var time_label: Label = $TimeLabel
@onready var tip_label: Label = $TipLabel


func back_to_prison():
	CurtainLayer.curtain_change_scene(prison_scene, "少女祈祷中。。。")


func _on_bg_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		back_to_prison()
