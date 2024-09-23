@tool
extends ScrollContainer
class_name GoodsList

const GOODS_LIST_ITEM = preload("res://Trade/Scene/TradeUI/goods_list_item.tscn")
@onready var v_box_container: VBoxContainer = $Panel/VBoxContainer
@onready var panel: Panel = $Panel



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
		if v_box_container:
			for item in v_box_container.get_children():
				item.custom_minimum_size.y=item_h


func add_list_item()->GoodsListItem:
	if GOODS_LIST_ITEM.can_instantiate():
		var item:GoodsListItem=GOODS_LIST_ITEM.instantiate()
		v_box_container.add_child(item)
		panel.custom_minimum_size.y=v_box_container.get_child_count()*item_h
		return item
	else:
		print("未找到 GOODSLISTITEM 场景文件")
		return

func clear_list():
	for item in v_box_container.get_children():
		item.queue_free()
