extends Node
class_name ModifierValue

enum Type { MULTIPLY, ADD }

@onready var modifier: Modifier = $".."

@export var source: String
@export var type: Type
@export var value: float:
	set(v):
		value = v
		value_changed.emit()

signal value_changed

func _ready() -> void:
	value_changed.connect(modifier._on_value_changed)
	value_changed.emit()

static func create_new_modifier_value(new_source: String, new_type: Type, new_value: float) -> ModifierValue:
	var new_modifier_value = ModifierValue.new()
	new_modifier_value.source = new_source
	new_modifier_value.type = new_type
	new_modifier_value.value = new_value
	return new_modifier_value
