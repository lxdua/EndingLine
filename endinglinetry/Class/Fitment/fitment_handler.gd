extends Node
class_name FitmentHandler

static var FITMENT_DICT: Dictionary = {
	"能源改进": preload("res://Resource/Fitment/能源改进/能源改进.tscn"),
	"JK": preload("res://Resource/Fitment/JK/jk.tscn"),
}

signal fitment_update

func has_fitment(fitment_name: String) -> bool:
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			return true
	return false

func get_fitment(fitment_name: String):
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			return fitment
	return null

func add_fitment(fitment_name: String):
	if not FITMENT_DICT.has(fitment_name):
		return
	if get_fitment(fitment_name) ==	null:
		var new_fitment: Fitment = FITMENT_DICT[fitment_name].instantiate()
		add_child(new_fitment)
	fitment_update.emit()

func remove_fitment(fitment_name: String):
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			fitment.queue_free()
	fitment_update.emit()

func clear_fitment():
	for fitment: Fitment in get_children():
		fitment.queue_free()
	fitment_update.emit()
