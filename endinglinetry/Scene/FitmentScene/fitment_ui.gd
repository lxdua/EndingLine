extends Control

@onready var icon: TextureRect = $Icon
@onready var name_label: Label = $NameLabel
@onready var content_label: RichTextLabel = $ContentLabel

var fitment: Fitment = null

func _ready() -> void:
	if fitment != null:
		icon.texture = fitment.icon
		name_label.text = fitment.fitment_name
		content_label.text = fitment.fitment_content
