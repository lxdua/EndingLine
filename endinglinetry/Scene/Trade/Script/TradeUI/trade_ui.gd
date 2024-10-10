extends CanvasLayer
class_name TradeUI
@onready var trade_manage: TradeManage = $".."
@onready var player_goods_list: GoodsList = $VBoxContainer/HBox/MarginContainer/PlayerGoodsList
@onready var goods_list: GoodsList = $VBoxContainer/HBox/MarginContainer2/GoodsList
@onready var goods_trade_details: GoodsTradeDetails = $GoodsTradeDetails


func _ready() -> void:
	pass





func update_list_layout():
	goods_list.fixed_icon_size=Vector2(1,1)*((get_viewport().size.x/2)/6)
	goods_list.fixed_column_width=goods_list.fixed_icon_size.x*1.1


func update_list_goods(player_goods:TradeGoods,goods:TradeGoods):
	var icon:=preload("res://icon.svg")
	player_goods_list.trade_goods=player_goods
	player_goods_list.updata_list()
	goods_list.trade_goods=goods
	goods_list.updata_list()

func show_goods_details(goods_item:TradeGoodsStruct):
	goods_trade_details.goods_struct=goods_item
	goods_trade_details.update_details()
	goods_trade_details.visible=true


func _on_exit_button_pressed() -> void:
	visible=false