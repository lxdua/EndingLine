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

var last_visit_time: int

@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var trade_goods: TradeGoods = $TradeGoods

func shold_update():
	var base_scene: BaseScene = get_tree().get_first_node_in_group("BaseScene")
	var d_time: = base_scene.current_time - last_visit_time
	if d_time >= 1440:
		return true
	var last_visit_date: = last_visit_time / 1440
	var last_visit_clock: = last_visit_time - last_visit_date * 1440
	var current_clock = base_scene.clock
	if (last_visit_clock <= 6 and 6 <= current_clock) or (current_clock <= 6 and 6 <= last_visit_clock):
		return true
	return false

func press_building():
	if shold_update():
		update_shop()
	trade_manage.open_trade_ui(trade_goods)

func update_shop():
	trade_goods.demand_arr=demand_arr
	trade_goods.demand_num=demand_num
	trade_goods.supply_arr=demand_arr
	trade_goods.supply_num=supply_num
	trade_goods.goods.clear()
	for s in supply_arr:
		var id: int = trade_manage.get_goods_id_by_name(s)
		if id == -1:
			continue
		trade_goods.add_goods(id,supply_num)
