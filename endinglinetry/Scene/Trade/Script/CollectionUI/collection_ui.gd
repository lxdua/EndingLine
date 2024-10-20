extends CanvasLayer
class_name CollectionUI

@onready var trade_manage:TradeManage = get_tree().get_first_node_in_group("TradeManage")

@onready var player_goods_list: VBoxContainer = %PlayerGoodsList
@onready var goods_list: VBoxContainer = %GoodsList
@onready var get_button: Button = %GetButton


const BACK_PACK_ITEM = preload("res://Scene/Trade/Scene/BackPackUI/back_pack_item.tscn")


@export var resources:Array[CollectionResource]


func update():
	for c in player_goods_list.get_children():
		player_goods_list.remove_child(c)
		c.queue_free()
	for c:PackItem in goods_list.get_children():
		goods_list.remove_child(c)
		c.queue_free()

	for g in trade_manage.player_trade_goods.goods:
		var item:PackItem = BACK_PACK_ITEM.instantiate()
		player_goods_list.add_child(item)
		item.trade_goods_struct=g
		item.update()
	for r in resources:
		var item:PackItem = BACK_PACK_ITEM.instantiate()
		var g_s=TradeGoodsStruct.new()
		goods_list.add_child(item)
		g_s.id=r.id
		g_s.number=r.number
		item.trade_goods_struct=g_s
		item.update()
		item.pressed.connect(_goods_list_item_pressed)

	get_button.disabled=goods_list.get_child_count()<=0

func _goods_list_item_pressed(item:PackItem):
	trade_manage.player_trade_goods.add_goods_by_struct(item.trade_goods_struct,9999)
	resources.all(func(r):
		if r.id==item.trade_goods_struct.id:
			resources.erase(r)
	)
	update()


func _on_get_button_pressed() -> void:
	for r in resources:
		trade_manage.player_trade_goods.add_goods(r.id,r.number)
	resources.clear()
	update()


func _on_close_button_pressed() -> void:
	visible=false
