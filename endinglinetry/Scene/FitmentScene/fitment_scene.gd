extends Control
class_name FitmentScene

const FITMENT_UI = preload("res://Scene/FitmentScene/fitment_ui.tscn")

@export var fitment_container: Container
@export var base_scene: BaseScene
@onready var fitment_handler: FitmentHandler = get_tree().get_first_node_in_group("FitmentHandler")

var fitment_list: Array[Fitment] = []

func _on_close_button_pressed() -> void:
	hide()
	base_scene.hide_all_secondary_scene()

func show_scene() -> void:
	get_fitment_list()
	update_fitment_ui()
	show()

func get_fitment_list():
	fitment_list.clear()
	for fitment: Fitment in fitment_handler.get_children():
		fitment_list.append(fitment)

func update_fitment_ui():
	for fitment_ui in fitment_container.get_children():
		fitment_ui.free()
	print(fitment_list)
	for fitment: Fitment in fitment_list:
		var fitment_ui: = FITMENT_UI.instantiate()
		fitment_ui.fitment = fitment
		fitment_container.add_child(fitment_ui)

# 获得顺序排序
func sort_by_acquisition_time():
	get_fitment_list()

# 持有人排序
func sort_by_holder():
	fitment_list.sort_custom(func(x: Fitment, y: Fitment):
		return x.holder < y.holder
		)

# 名字排序
func sort_by_name():
	fitment_list.sort_custom(func(x: Fitment, y: Fitment):
		return x.fitment_name.casecmp_to(y.fitment_name) < 0
		)
