extends CenterContainer
class_name GoodsTradeDetails

@onready var trade_manage: TradeManage = $"../.."
@onready var goods_name: Label = $PanelContainer/VBoxContainer/CenterContainer/GoodsName
@onready var goods_number: Label = $PanelContainer/VBoxContainer/VBox/CenterContainer/GoodsNumber
@onready var number_scroll_bar: HScrollBar = $PanelContainer/VBoxContainer/VBox/HBoxContainer/CenterContainer/NumberScrollBar
@onready var number_price: Label = $PanelContainer/VBoxContainer/VBox/CenterContainer2/NumberPrice


var goods_struct:TradeGoodsStruct

func update_details():
	if goods_struct:
		goods_name.text=trade_manage.get_goods_name(goods_struct.id)
		number_scroll_bar.max_value=goods_struct.number
		number_scroll_bar.value=2
		number_scroll_bar.value=1



func _on_number_scroll_bar_value_changed(value: float) -> void:
	goods_number.text=str(int(value))+"/"+str(number_scroll_bar.max_value)
	if goods_struct:
		number_price.text="总价:"+str(int(value*goods_struct.price_multiplier*trade_manage.get_goods_price(goods_struct.id)))



func _on_number_down_pressed() -> void:
	number_scroll_bar.value-=1


func _on_number_up_pressed() -> void:
	number_scroll_bar.value+=1



func _on_details_cancel_pressed() -> void:
	visible=false


func _on_details_trade_pressed() -> void:
	pass # Replace with function body.
