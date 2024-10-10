extends PanelContainer
class_name PackItem
@onready var icon: TextureRect = $HBoxContainer/MarginContainer/Icon
@onready var number_label: Label = $HBoxContainer/VBoxContainer/NumberLabel
@onready var price_label: Label = $HBoxContainer/VBoxContainer/PriceLabel
@onready var heavy_label: Label = $HBoxContainer/VBoxContainer/HeavyLabel
@onready var reference_rect: ReferenceRect = $ReferenceRect

@onready var back_pack_ui: BackPackUI = get_tree().get_first_node_in_group("PackUI")
var trade_goods_struct:TradeGoodsStruct


func update():
	number_label.text = "数量:"+str(trade_goods_struct.number)
	price_label.text = "总价:"+str(get_tree().get_first_node_in_group("TradeManage").get_goods_price(trade_goods_struct.id)*trade_goods_struct.number)
	heavy_label.text = "总重:"+str(get_tree().get_first_node_in_group("TradeManage").get_goods_heavy(trade_goods_struct.id)*trade_goods_struct.number)


func _on_reference_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.pressed:
				back_pack_ui.selected_item = trade_goods_struct
				back_pack_ui.update_select()
