extends Node
class_name ModifierValue

enum Type { MULTIPLY, ADD }

@export var type: Type
@export var value: int
@export var source: String

static func create_new_modifier_value(source: String, type: Type, value: int) -> ModifierValue:
	var new_modifier_value = ModifierValue.new()
	new_modifier_value.source = source
	new_modifier_value.type = type
	new_modifier_value.value = value
	return new_modifier_value
