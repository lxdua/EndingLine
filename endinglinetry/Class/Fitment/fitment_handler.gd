extends Node
class_name FitmentHandler

func has_fitment(fitment_name: String) -> bool:
	for fitment: Fitment in get_children():
		if fitment.fitment_name == fitment_name:
			return true
	return false

func add_fitment():
	pass

func remove_fitment():
	pass

func clear_fitment():
	for fitment: Fitment in get_children():
		fitment.queue_free()
