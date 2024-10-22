extends Control


@onready var content_label: Label = $PanelContainer/VBoxContainer/ContentLabel
@onready var yes_button: Button = $PanelContainer/VBoxContainer/HBoxContainer/YesButton
@onready var no_button: Button = $PanelContainer/VBoxContainer/HBoxContainer/NoButton


## 文字内容
var content: String

## 是否可以按下“确定”按钮
var can_press_yes: bool = true

## 给回去的结果
var result: bool

## 告诉问题来源玩家已经确定结果
signal finish

func _ready() -> void:
	yes_button.disabled = not can_press_yes
	content_label.text = content

func _on_yes_button_pressed() -> void:
	result = true
	finish.emit()
	queue_free()
	print("yes")

func _on_no_button_pressed() -> void:
	result = false
	finish.emit()
	queue_free()
	print("no")
