extends Node
class_name Fitment

enum Holder { TRAIN, AKI, RUU }

@export var fitment_name: String
@export var icon: Texture
@export var holder: Holder
@export_multiline var fitment_content: String
@export var pre_fitment_name_list: Array[String]

## 获得这个fitment时
func activate():
	pass

## 丢失这个fitment时
func deactivate():
	pass

func _ready() -> void:
	name = fitment_name
