extends Node
class_name Modifier

@export var modifier_name: String

func get_value(source: String) -> ModifierValue:
	for value: ModifierValue in get_children():
		if value.source == source:
			return value
	return null

func add_new_value(value: ModifierValue):
	var modifier_value := get_value(value.source)
	if not modifier_value:
		add_child(value)
	else:
		modifier_value.multiply_value = value.multiply_value
		modifier_value.add_value = value.add_value

func remove_value(source: String):
	for value: ModifierValue in get_children():
		if value.source == source:
			value.queue_free()

func clear_value():
	for value: ModifierValue in get_children():
		value.queue_free()

func get_modifier_value(base: int) -> int:
	var result: = base
	for value: ModifierValue in get_children():
		var addition: = base
		match ModifierValue.Type:
			ModifierValue.Type.MULTIPLY:
				addition *= value.value
			ModifierValue.Type.ADD:
				addition += value.value
		result += addition
	return result
