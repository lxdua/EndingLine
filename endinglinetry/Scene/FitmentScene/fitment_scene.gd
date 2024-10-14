extends Control
class_name FitmentScene

const FITMENT_UI = preload("res://Scene/FitmentScene/fitment_ui.tscn")

@export var fitment_container: VBoxContainer

@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")
@onready var fitment_handler: FitmentHandler = train_stats_manager.fitment_handler

var fitment_list: Array[Fitment] = []

func get_fitment_list():
	fitment_list.clear()
	for fitment: Fitment in fitment_handler.get_children():
		fitment_list.append(fitment)

func update_fitment_ui():
	for fitment_ui in fitment_container.get_children():
		fitment_ui.free()
	for fitment: Fitment in fitment_list:
		var fitment_ui: = FITMENT_UI.instantiate()
		fitment_ui.update_ui(fitment)
		fitment_container.add_child(fitment_ui)

# 获得顺序排序
func sort_by_acquisition_time():
	get_fitment_list()

# 持有人排序
func sort_by_holder():
	fitment_list.sort_custom(func(x: Fitment, y: Fitment):
		return x.holder.casecmp_to(y.holder) < 0
		)

# 名字排序
func sort_by_name():
	fitment_list.sort_custom(func(x: Fitment, y: Fitment):
		return x.fitment_name.casecmp_to(y.fitment_name) < 0
		)


func _on_close_button_pressed() -> void:
	hide()
