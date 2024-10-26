@tool
extends PanelContainer
class_name GoodsListItem

@onready var icon_rect: TextureRect = $HBoxContainer/MarginContainer/IconRect
@onready var trade_manage: TradeManage = get_tree().get_nodes_in_group("TradeManage")[0]
@onready var trade_ui: TradeUI = get_tree().get_nodes_in_group("TradeUI")[0]
@onready var heavy_label: Label = %HeavyLabel
@onready var multiplier_label: Label = %MultiplierLabel
@onready var price_label: Label = %PriceLabel
@onready var name_label: Label = %NameLabel
@onready var number_label: Label = %NumberLabel



const ICON = preload("res://icon.svg")
@export var icon:Texture2D=preload("res://icon.svg"):
	set(new_icon):
		icon=new_icon
		icon_rect.texture=icon
@export var goods_name:String="物品名称":
	set(new_name):
		goods_name=new_name
		update_item_data_text()
@export_range(1,99999) var goods_price:int=1:
	set(new_price):
		goods_price=new_price
		update_item_data_text()
@export_range(0,99) var price_multiplier:float=1:
	set(new_multiplier):
		price_multiplier=new_multiplier
		update_item_data_text()
@export_range(0,99999) var goods_number:int:
	set(new_number):
		goods_number=new_number
		update_item_data_text()


func update_item_data_text():
	name_label.text = goods_name
	number_label.text = str(goods_number)

	var heavy_num: int
	var multiplier_num: int
	var price_num: int

	if goods_struct.trade_goods and goods_struct.trade_goods==trade_manage.player_trade_goods:
		if !trade_manage.trade_partner.goods:
			heavy_num = trade_manage.get_goods_heavy(goods_struct.id)
			multiplier_num = trade_manage.sell_multiplier*100
			price_num = goods_price*trade_manage.sell_multiplier
		else:
			var goods_filter := trade_manage.trade_partner.goods.filter(func(g):
				if g.id==goods_struct.id:
					return true
				else:
					return false
			)
			if goods_filter:
				heavy_num = trade_manage.get_goods_heavy(goods_struct.id)
				multiplier_num = goods_filter[0].price_multiplier*trade_manage.sell_multiplier*100
				price_num = goods_price*goods_filter[0].price_multiplier*trade_manage.sell_multiplier
			else:
				heavy_num = trade_manage.get_goods_heavy(goods_struct.id)
				multiplier_num = trade_manage.sell_multiplier*100
				price_num = goods_price*trade_manage.sell_multiplier
	else:
		heavy_num = trade_manage.get_goods_heavy(goods_struct.id)
		multiplier_num = price_multiplier*100
		price_num = goods_price*price_multiplier

	# dua
	var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")

	if goods_struct.trade_goods and goods_struct.trade_goods==trade_manage.player_trade_goods:
		price_num = modifier_handler.get_modifier_result_intelligently("selling_price", price_num)
	else:
		price_num = modifier_handler.get_modifier_result_intelligently("buying_price", price_num)

	heavy_label.text = str(heavy_num)
	multiplier_label.text = str(multiplier_num)+"%"
	price_label.text = str(price_num)


var goods_struct:TradeGoodsStruct:
	set(new_g):
		goods_struct=new_g
		update()


func update():
	if goods_struct:
		goods_name=trade_manage.get_goods_name(goods_struct.id)
		goods_price=trade_manage.get_goods_price(goods_struct.id)
		price_multiplier=goods_struct.price_multiplier
		if goods_struct.trade_goods==trade_manage.player_trade_goods:
			goods_number=(goods_struct.number if goods_struct.number<goods_struct.demand_num else goods_struct.demand_num)
		else:
			goods_number=goods_struct.number
		var i := trade_manage.get_goods_icon(goods_struct.id)
		if i:
			icon = i
		else:
			icon = ICON



func _on_reference_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.pressed:
				trade_ui.show_goods_details(goods_struct)
