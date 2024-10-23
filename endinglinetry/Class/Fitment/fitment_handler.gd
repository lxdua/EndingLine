extends Node
class_name FitmentHandler

var fitment_dict: Dictionary

func _ready() -> void:
	fitment_dict = get_fitment_dict()

func get_fitment_dict():
	var dict: Dictionary
	var path: String = "res://Resource/Fitment/FitmentNode/"
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			continue
		dict[file_name.left(-5)] = load(path + file_name)
		file_name = dir.get_next()
	return dict

signal fitment_update

func has_fitment_by_name(fitment_name: String) -> bool:
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			return true
	return false

func get_fitment_by_name(fitment_name: String):
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			return fitment
	return null

func add_fitment_by_name(fitment_name: String):
	if not fitment_dict.has(fitment_name):
		return
	if get_fitment_by_name(fitment_name) ==	null:
		var new_fitment: Fitment = fitment_dict[fitment_name].instantiate()
		add_fitment(new_fitment)

func remove_fitment_by_name(fitment_name: String):
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			fitment.queue_free()
	fitment_update.emit()

func clear_fitment():
	for fitment: Fitment in get_children():
		remove_fitment(fitment)
	fitment_update.emit()

func add_fitment(new_fitment: Fitment):
	add_child(new_fitment)
	new_fitment.activate()
	fitment_update.emit()

func remove_fitment(fitment: Fitment):
	fitment.deactivate()
	fitment.queue_free()
	fitment_update.emit()
