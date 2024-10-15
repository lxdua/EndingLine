extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/VBoxContainer/Icon
@onready var content_label: RichTextLabel = $MarginContainer/VBoxContainer/ContentLabel

var fitment: Fitment = null

func _ready() -> void:
	if fitment != null:
		icon.texture = fitment.icon
		content_label.text = fitment.fitment_content
