extends TextureRect

@onready var content_container: PanelContainer = $ContentContainer
@onready var content_label: RichTextLabel = $ContentContainer/MarginContainer/ContentLabel

func update_ui(buff: Buff):
	texture = buff.icon
	content_label.text = ""
	content_label.text += "[center]" + buff.buff_name + "[/center]\n"
	content_label.text += buff.buff_content


func _on_mouse_entered() -> void:
	content_container.show()

func _on_mouse_exited() -> void:
	content_container.hide()
