@tool
extends ScrollContainer
class_name GoodsList

const GOODS_LIST_ITEM = preload("res://Trade/Scene/TradeUI/goods_list_item.tscn")
@onready var list: VBoxContainer = $Panel/VBoxContainer/List
@onready var panel: Panel = $Panel
@onready var cash_label: Label = $Panel/VBoxContainer/PanelContainer/CashLabel

var trade_goods:TradeGoods:
	set(new_g):
		trade_goods=new_g
		updata_list()


@export var add_item:bool:
	set(new_b):
		add_item=false
		return add_list_item()
@export var clear:bool:
	set(new_b):
		clear=false
		clear_list()
@export_range(1,9999) var item_h:int=100:
	set(new_num):
		item_h=new_num
		if list:
			for item in list.get_children():
				item.custom_minimum_size.y=item_h
				item.item_data_text.add_theme_font_size_override("font_size",item_h/4)
@export_range(0,999999) var cash:int:
	set(new_c):
		cash=new_c
		if !cash_label:
			await ready
		cash_label.text="现金:"+str(cash)

func add_list_item()->GoodsListItem:
	if GOODS_LIST_ITEM.can_instantiate():
		var item:GoodsListItem=GOODS_LIST_ITEM.instantiate()
		list.add_child(item)
		panel.custom_minimum_size.y=list.get_child_count()*item_h
		return item
	else:
		print("未找到 GOODSLISTITEM 场景文件")
		return

func clear_list():
	for item in list.get_children():
		item.queue_free()

func updata_list():
	clear_list()
	for g in trade_goods.goods:
		if g.number>0:
			add_list_item().goods_struct=g
	cash=trade_goods.cash
