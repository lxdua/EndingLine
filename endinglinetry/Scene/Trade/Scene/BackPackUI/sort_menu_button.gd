extends MenuButton
class_name SortMenuButton
@onready var back_pack_ui: BackPackUI = get_tree().get_first_node_in_group("PackUI")

var sort_id:int=0

func _ready() -> void:
	get_popup()
	get_popup().id_pressed.connect(_popup_pressed)
	text=get_popup().get_item_text(0)


func _popup_pressed(id:int):
	sort_id=id
	text=get_popup().get_item_text(id)
	back_pack_ui.update()
