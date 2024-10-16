extends Node2D

@onready var fog: Fog = $Fog
@onready var trade_manage: TradeManage = $TradeManage
@onready var trade_goods: TradeGoods = $TradeGoods


func _on_sprite_2d_pressed() -> void:
	if fog.is_in_light(get_global_mouse_position()):
		print("按下")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			if event.pressed:
				trade_manage.open_pack_ui()


func _on_button_pressed() -> void:
	trade_manage.open_trade_ui(trade_goods)
