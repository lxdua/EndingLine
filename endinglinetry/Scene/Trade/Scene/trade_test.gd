extends Node2D

@onready var fog: Fog = $Fog
@onready var trade_manage: TradeManage = $TradeManage
@onready var trade_goods: TradeGoods = $TradeGoods

@export var collection_resource:Array[CollectionResource]

func _on_sprite_2d_pressed() -> void:
	if fog.is_in_light(get_global_mouse_position()):
		print("按下")

func _input(event: InputEvent) -> void:
	if !(event is InputEventKey):
		return
	if !event.pressed:
		return
	if event.keycode == KEY_Q:
		trade_manage.open_back_pack_ui()
	elif event.keycode == KEY_W:
		trade_manage.open_collection_ui(collection_resource.duplicate())


func _on_button_pressed() -> void:
	trade_manage.open_trade_ui(trade_goods)
