extends CanvasLayer
class_name CollectionUI

@onready var trade_manage:TradeManage = get_tree().get_first_node_in_group("TradeManage")

@onready var player_goods_list: VBoxContainer = %PlayerGoodsList
@onready var goods_list: VBoxContainer = %GoodsList


const BACK_PACK_ITEM = preload("res://Scene/Trade/Scene/BackPackUI/back_pack_item.tscn")


@export var resources:Array[CollectionResource]


func update():
	for c in player_goods_list.get_children():
		player_goods_list.remove_child(c)
		c.queue_free()
	for c:PackItem in goods_list.get_children():
		goods_list.remove_child(c)
		c.trade_goods_struct.free()
		c.queue_free()

	for g in trade_manage.player_trade_goods.goods:
		var item:PackItem = BACK_PACK_ITEM.instantiate()
		item.trade_goods_struct=g
		item.update()
		player_goods_list.add_child(item)
	for r in resources:
		var item:PackItem = BACK_PACK_ITEM.instantiate()
		var g_s=TradeGoodsStruct.new()
		g_s.id=r.id
		g_s.number=r.number
		item.trade_goods_struct=g_s
		item.update()
		goods_list.add_child(item)



func _on_get_button_pressed() -> void:
	pass # Replace with function body.0


func _on_close_button_pressed() -> void:
	pass # Replace with function body.
