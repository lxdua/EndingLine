extends Node
class_name Fitment

@export var fitment_name: String
@export var icon: Texture
@export var holder: String
@export_multiline var fitment_content: String

## 获得这个fitment时
func activate():
	pass

## 丢失这个fitment时
func deactivate():
	pass


func _enter_tree() -> void:
	activate()

func _exit_tree() -> void:
	deactivate()
