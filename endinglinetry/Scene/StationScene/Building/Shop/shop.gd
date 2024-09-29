extends Building
class_name Shop

@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var trade_goods: TradeGoods = $TradeGoods

func press_building():
	trade_manage.open_trade_ui(trade_goods)
