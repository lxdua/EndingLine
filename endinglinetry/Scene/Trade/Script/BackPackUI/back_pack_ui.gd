extends CanvasLayer
class_name BackPackUI

@onready var number_label: Label = %NumberLabel
@onready var max_number_label: Label = %MaxNumberLabel
@onready var sort_menu_button: SortMenuButton = %SortMenuButton
@onready var pack_item_list: VBoxContainer = %PackItemList
@onready var exit_button: Button = %ExitButton
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var pack_item_details: PackItemDetails = %PackItemDetails
@onready var pack_item_discard: PackItemDiscard = $PackItemDiscard
@onready var cash_label: Label = %CashLabel

const PACK_ITEM = preload("uid://b0f6khkqepsmf")


var trade_goods:TradeGoods
var selected_item:TradeGoodsStruct

func update():
	if trade_goods:
		cash_label.text = str(trade_goods.cash)
		max_number_label.text=str(trade_goods.max_load)
		number_label.text = str(trade_goods.get_current_load())
		progress_bar.max_value = trade_goods.max_load
		progress_bar.value = trade_goods.get_current_load()

		trade_goods.goods_sort(sort_menu_button.sort_id)
		for c in pack_item_list.get_children():
			c.queue_free()
		for g in trade_goods.goods:
			if g.number>0:
				var item:PackItem=PACK_ITEM.instantiate()
				pack_item_list.add_child(item)
				item.trade_goods_struct=g
				item.update()
		if !selected_item or selected_item.number<=0:
			await get_tree().create_timer(0.01).timeout
			if pack_item_list.get_child(0):
				selected_item=pack_item_list.get_child(0).trade_goods_struct
			else:
				selected_item=null
		update_select()

func update_select():
	for c:PackItem in pack_item_list.get_children():
		c.reference_rect.editor_only=!c.trade_goods_struct==selected_item
	pack_item_details.update()

func open_discard():
	pack_item_discard.trade_goods_struct=selected_item
	pack_item_discard.update()
	pack_item_discard.visible=true


func _on_exit_button_pressed() -> void:
	visible=false
	#dua
	get_tree().get_first_node_in_group("TrainStatsManager").current_money = trade_goods.cash
	get_tree().get_first_node_in_group("BaseScene").hide_all_secondary_scene()
