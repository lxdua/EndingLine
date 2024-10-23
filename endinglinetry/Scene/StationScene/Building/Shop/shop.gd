extends Building
class_name Shop

# 税率
var tax_rate: float
# 需
var demand_arr: Array
var demand_num: int
# 供
var supply_arr: Array
var supply_num: int

@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var trade_goods: TradeGoods = $TradeGoods

func press_building():
	trade_manage.open_trade_ui(trade_goods)

func update_shop():
	trade_goods.demand_arr=demand_arr
	trade_goods.demand_num=demand_num
	trade_goods.supply_arr=demand_arr
	trade_goods.supply_num=supply_num
	for s in supply_arr:
		var id: int = trade_manage.get_goods_id_by_name(s)
		if id == -1:
			continue
		trade_goods.add_goods(id,supply_num)
