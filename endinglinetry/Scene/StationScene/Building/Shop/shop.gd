extends Building
class_name Shop

# 税率
var tax_rate: float
# 需
var demand_arr: PackedStringArray
var demand_num: int
# 又供又需
var supply_and_demand_arr: PackedStringArray
var supply_and_demand_num: int
# 供
var supply_arr: PackedStringArray
var supply_num: int

@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var trade_goods: TradeGoods = $TradeGoods

func press_building():
	trade_manage.open_trade_ui(trade_goods)

func _ready() -> void:
	pass
