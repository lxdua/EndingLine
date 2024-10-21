extends Building
class_name Shop

## 税率
var station_tax_rate: float


## 供表
var station_supply: Array

## 需表
var station_demand: Array


@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var trade_goods: TradeGoods = $TradeGoods

func press_building():
	trade_manage.open_trade_ui(trade_goods)

func _ready() -> void:
	for supply in station_supply:
		trade_goods.add_goods(supply.good_id, supply.good_num)
