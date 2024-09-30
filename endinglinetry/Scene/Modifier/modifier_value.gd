extends Node
class_name ModifierValue

enum Type { MULTIPLY, ADD }

@onready var modifier: Modifier = $".."

@export var source: String
@export var type: Type
@export var value: float:
	set(v):
		value = v
		modifier.value_changed.emit()

func _ready() -> void:
	modifier.value_changed.emit()

static func create_new_modifier_value(source: String, type: Type, value: float) -> ModifierValue:
	var new_modifier_value = ModifierValue.new()
	new_modifier_value.source = source
	new_modifier_value.type = type
	new_modifier_value.value = value
	return new_modifier_value
