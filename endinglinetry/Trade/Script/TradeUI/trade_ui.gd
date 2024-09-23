extends CanvasLayer
class_name TradeUI
@onready var trade_manage: TradeManage = $".."
@onready var player_goods_list: GoodsList = $VBoxContainer/HBox/MarginContainer/PlayerGoodsList
@onready var goods_list: ItemList = $VBoxContainer/HBox/MarginContainer2/GoodsList
@onready var goods_trade_details: GoodsTradeDetails = $GoodsTradeDetails


func _ready() -> void:
	pass





func update_list_layout():
	goods_list.fixed_icon_size=Vector2(1,1)*((get_viewport().size.x/2)/6)
	goods_list.fixed_column_width=goods_list.fixed_icon_size.x*1.1


var list_goods_map:Dictionary
func update_list_goods(player_goods:TradeGoods,goods:TradeGoods):
	var icon:=preload("res://icon.svg")
	player_goods_list.clear_list()
	for g in player_goods.goods:
		if g.number>0:
			player_goods_list.add_list_item().goods_struct=g
	goods_list.clear()
	list_goods_map.clear()
	for g in goods.goods:
		if g.number>0:
			list_goods_map[goods_list.add_item(str(g.number),icon,false)]=g

func show_goods_details(goods_item:TradeGoodsStruct):
	goods_trade_details.goods_struct=goods_item
	goods_trade_details.update_details()
	goods_trade_details.visible=true
