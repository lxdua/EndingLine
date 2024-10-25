extends TextureRect
class_name PackItem
@onready var icon: TextureRect = %Icon
@onready var number_label: Label = %NumberLabel
@onready var price_label: Label = %PriceLabel
@onready var heavy_label: Label = %HeavyLabel
@onready var reference_rect: ReferenceRect = $ReferenceRect
@onready var name_label: Label = %NameLabel


@onready var back_pack_ui: BackPackUI = get_tree().get_first_node_in_group("PackUI")
@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
var trade_goods_struct:TradeGoodsStruct


func update():
	if trade_goods_struct:
		if trade_manage.get_goods_icon(trade_goods_struct.id):
			icon.texture=trade_manage.get_goods_icon(trade_goods_struct.id)
		name_label.text = trade_manage.get_goods_name(trade_goods_struct.id)
		number_label.text = str(trade_goods_struct.number)

		var price: int = get_tree().get_first_node_in_group("TradeManage").get_goods_price(trade_goods_struct.id)*trade_goods_struct.number
		var heavy: int = get_tree().get_first_node_in_group("TradeManage").get_goods_heavy(trade_goods_struct.id)*trade_goods_struct.number

		price_label.text = str(price)
		heavy_label.text = str(heavy)

signal pressed(item)
func _on_reference_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.pressed:
				emit_signal("pressed",self)
				back_pack_ui.selected_item = trade_goods_struct
				back_pack_ui.update_select()
