@tool
extends ScrollContainer
class_name GoodsList

const GOODS_LIST_ITEM = preload("res://Trade/Scene/TradeUI/goods_list_item.tscn")

@onready var v_box_container: VBoxContainer = $VBoxContainer


@export var add_item:bool:
	set(new_b):
		add_item=false
		return add_list_item()



func add_list_item()->GoodsListItem:
	if GOODS_LIST_ITEM.can_instantiate():
		var item:GoodsListItem=GOODS_LIST_ITEM.instantiate()
		v_box_container.add_child(item)
		return item
	else:
		print("未找到 GOODSLISTITEM 场景文件")
		return
