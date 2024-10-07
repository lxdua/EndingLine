extends Building
class_name Shop

@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var trade_goods: TradeGoods = $TradeGoods

func press_building():
	trade_manage.open_trade_ui(trade_goods)

## 税率
@export var station_tax_rate: float

## 供需表
@export var station_supply_and_demand: Array[SupplyAndDemandRes]
