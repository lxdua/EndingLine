extends Node
class_name Modifier

@export var modifier_name: String

var update_signal: Signal = Signal()

func _on_value_changed():
	if update_signal == Signal():
		return
	update_signal.emit()

func _init(modifier_name: String) -> void:
	self.modifier_name = modifier_name
	self.name = modifier_name

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
		modifier_value.value = value.value

func remove_value(source: String):
	for value: ModifierValue in get_children():
		if value.source == source:
			value.queue_free()

func clear_value():
	for value: ModifierValue in get_children():
		value.queue_free()

func get_modifier_value(base: float) -> float:
	var result: float = base
	for value: ModifierValue in get_children():
		match value.type:
			ModifierValue.Type.MULTIPLY:
				result += base * value.value
			ModifierValue.Type.ADD:
				result += value.value
	return result
