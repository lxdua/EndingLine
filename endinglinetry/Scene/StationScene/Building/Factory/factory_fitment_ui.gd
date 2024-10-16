extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/VBoxContainer/Icon
@onready var content_label: RichTextLabel = $MarginContainer/VBoxContainer/ContentLabel

var fitment: Fitment = null

func _ready() -> void:
	if fitment != null:
		icon.texture = fitment.icon
		content_label.text = fitment.fitment_content

signal factory_fitment_button_pressed(fitment_name: String)
func _on_factory_fitment_button_pressed() -> void:
	factory_fitment_button_pressed.emit(fitment.fitment_name)
