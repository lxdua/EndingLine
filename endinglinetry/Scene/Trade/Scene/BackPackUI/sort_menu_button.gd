extends MenuButton
class_name SortMenuButton


func _ready() -> void:
	get_popup().id_pressed.connect(_popup_pressed)
	text=get_popup().get_item_text(0)

func _popup_pressed(id:int):
	text=get_popup().get_item_text(id)
