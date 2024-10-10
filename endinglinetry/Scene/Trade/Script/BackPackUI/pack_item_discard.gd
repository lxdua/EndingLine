extends CenterContainer
class_name PackItemDiscard
@onready var goods_name: Label = %GoodsName
@onready var goods_number: Label = %GoodsNumber
@onready var number_scroll_bar: HScrollBar = %NumberScrollBar
@onready var number_heavy: Label = %NumberHeavy

@onready var trade_manage:TradeManage=get_tree().get_first_node_in_group("TradeManage")

var trade_goods_struct:TradeGoodsStruct

func update():
	if trade_goods_struct:
		goods_name.text = trade_manage.get_goods_name(trade_goods_struct.id)
		number_scroll_bar.max_value = trade_goods_struct.number
		goods_number.text = "丢弃数量:"+str(number_scroll_bar.value)+"/"+str(number_scroll_bar.max_value)
		number_heavy.text = "丢弃重量:"+str(number_scroll_bar.value*trade_manage.get_goods_heavy(trade_goods_struct.id))
		number_scroll_bar.value=1


func _on_number_down_pressed() -> void:
	number_scroll_bar.value-=1


func _on_number_up_pressed() -> void:
	number_scroll_bar.value+=1


func _on_details_cancel_pressed() -> void:
	visible=false


func _on_dicard_button_pressed() -> void:
	trade_goods_struct.number-=number_scroll_bar.value
	get_tree().get_first_node_in_group("PackUI").update()
	visible=false


func _on_number_scroll_bar_value_changed(value: float) -> void:
	goods_number.text = "丢弃数量"+str(number_scroll_bar.value)+"/"+str(number_scroll_bar.max_value)
	number_heavy.text = "丢弃重量:"+str(number_scroll_bar.value*trade_manage.get_goods_heavy(trade_goods_struct.id))
