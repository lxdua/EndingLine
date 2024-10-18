extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/HBoxContainer/Icon
@onready var name_label: Label = $MarginContainer/HBoxContainer/NameLabel
@onready var holder_label: Label = $MarginContainer/HBoxContainer/HolderLabel
@onready var content_label: RichTextLabel = $MarginContainer/HBoxContainer/MarginContainer/ContentLabel

var fitment: Fitment = null

func _ready() -> void:
	if fitment != null:
		icon.texture = fitment.icon
		name_label.text = fitment.fitment_name
		content_label.text = fitment.fitment_content
		if fitment.holder == Fitment.Holder.TRAIN:
			holder_label.text = "Train"
		elif fitment.holder == Fitment.Holder.AKI:
			holder_label.text = "Aki"
		elif fitment.holder == Fitment.Holder.RUU:
			holder_label.text = "Ruu"
