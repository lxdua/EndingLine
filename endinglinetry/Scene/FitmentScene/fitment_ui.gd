extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/HBoxContainer/Icon
@onready var name_label: Label = $MarginContainer/HBoxContainer/NameLabel
@onready var holder_label: Label = $MarginContainer/HBoxContainer/HolderLabel
@onready var content_label: RichTextLabel = $MarginContainer/HBoxContainer/MarginContainer/ContentLabel

func update_ui(fitment: Fitment):
	icon.texture = fitment.icon
	name_label.text = fitment.fitment_name
	holder_label.text = fitment.holder
	content_label.text = fitment.content
