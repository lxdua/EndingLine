extends Node2D

@onready var trade_goods: TradeGoods = $Button/TradeGoods

func _on_button_pressed() -> void:
	get_tree().get_nodes_in_group("TradeManage")[0].open_trade_ui(trade_goods)
