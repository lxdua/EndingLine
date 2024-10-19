extends CenterContainer
class_name GoodsTradeDetails

@onready var trade_manage: TradeManage = get_tree().get_first_node_in_group("TradeManage")
@onready var goods_name: Label = %GoodsName
@onready var goods_number: Label = %GoodsNumber
@onready var number_scroll_bar: HScrollBar = %NumberScrollBar
@onready var number_price: Label = %NumberPrice

@onready var popup: PanelContainer = $Popup
@onready var timer: Timer = $Popup/Timer

var trade_goods:TradeGoods
var goods_struct:TradeGoodsStruct

func update_details():
	if goods_struct:
		goods_name.text=trade_manage.get_goods_name(goods_struct.id)
		number_scroll_bar.max_value=goods_struct.number
		number_scroll_bar.value=1
		number_scroll_bar.value=number_scroll_bar.max_value
		goods_number.text=str(int(number_scroll_bar.value))+"/"+str(number_scroll_bar.max_value)



func _on_number_scroll_bar_value_changed(value: float) -> void:
	goods_number.text=str(int(value))+"/"+str(number_scroll_bar.max_value)
	if goods_struct:
		if goods_struct.trade_goods and goods_struct.trade_goods==trade_manage.player_trade_goods:
			if !trade_manage.trade_partner.goods:
				number_price.text="总价:"+str(int(value*max(goods_struct.price_multiplier*trade_manage.get_goods_price(goods_struct.id)*trade_manage.sell_multiplier,1)))
				return
			trade_manage.trade_partner.goods.filter(func(g):
				if g.id==goods_struct.id:
					number_price.text="总价:"+str(int(value*max(g.price_multiplier*trade_manage.get_goods_price(goods_struct.id)*trade_manage.sell_multiplier,1)))
					return true
				else:
					number_price.text="总价:"+str(int(value*max(goods_struct.price_multiplier*trade_manage.get_goods_price(goods_struct.id)*trade_manage.sell_multiplier,1)))
			)
		else:
			number_price.text="总价:"+str(int(value*max(goods_struct.price_multiplier*trade_manage.get_goods_price(goods_struct.id),1)))



func _on_number_down_pressed() -> void:
	number_scroll_bar.value-=1


func _on_number_up_pressed() -> void:
	number_scroll_bar.value+=1



func _on_details_cancel_pressed() -> void:
	visible=false



func _on_details_trade_pressed() -> void:
	if trade_manage.Trade(goods_struct,number_scroll_bar.value):
		trade_manage.update_list_goods()
		visible=false
	else:
		timer.stop()
		timer.start(1)
		popup.visible=true




func _on_popup_draw() -> void:
	timer.stop()
	timer.start(1)



func _on_timer_timeout() -> void:
	popup.visible=false
