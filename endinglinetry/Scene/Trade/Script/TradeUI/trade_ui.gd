extends CanvasLayer
class_name TradeUI
@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var player_goods_list: GoodsList = %PlayerGoodsList
@onready var goods_list: GoodsList = %GoodsList
@onready var goods_trade_details: GoodsTradeDetails = %GoodsTradeDetails


func _ready() -> void:
	pass


func update_list_layout():
	goods_list.fixed_icon_size=Vector2(1,1)*((get_viewport().size.x/2)/6)
	goods_list.fixed_column_width=goods_list.fixed_icon_size.x*1.1

# 需
var demand_arr: PackedStringArray
var demand_num: int
# 供
var supply_arr: PackedStringArray
var supply_num: int
func update_list_goods(player_goods:TradeGoods,goods:TradeGoods):
	var icon:=preload("res://icon.svg")
	demand_arr=goods.demand_arr
	demand_num=goods.demand_num
	supply_arr=goods.supply_arr
	supply_num=goods.supply_num

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
	#dua
	get_tree().get_first_node_in_group("TrainStatsManager").current_money = get_tree().get_first_node_in_group("TradeManage").player_trade_goods.cash


func _on_go_button_pressed() -> void:
	visible=false
