extends CanvasLayer
class_name TradeUI
@onready var trade_manage: TradeManage = $".."
@onready var player_goods_list: ItemList = $VBoxContainer/HBox/MarginContainer/PlayerGoodsList
@onready var goods_list: ItemList = $VBoxContainer/HBox/MarginContainer2/GoodsList


func _ready() -> void:
	reset_list_layout()





func reset_list_layout():
	player_goods_list.fixed_icon_size=Vector2(1,1)*((get_viewport().size.x/2)/6)
	player_goods_list.fixed_column_width=player_goods_list.fixed_icon_size.x*1.1
	goods_list.fixed_icon_size=Vector2(1,1)*((get_viewport().size.x/2)/6)
	goods_list.fixed_column_width=goods_list.fixed_icon_size.x*1.1


var player_list_goods_map:Dictionary
var list_goods_map:Dictionary
func reset_list_goods(player_goods:TradeGoods,goods:TradeGoods):
	var icon:=preload("res://icon.svg")
	player_goods_list.clear()
	player_list_goods_map.clear()
	for g in player_goods.goods:
		if g.number>0:
			player_list_goods_map[player_goods_list.add_item(str(g.number),icon,(g.number>0))]=g

	goods_list.clear()
	list_goods_map.clear()
	for g in goods.goods:
		if g.number>0:
			list_goods_map[goods_list.add_item(str(g.number),icon)]=g
