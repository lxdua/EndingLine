extends Node2D
class_name TradeManage
@onready var player_trade_goods: TradeGoods = $PlayerTradeGoods
@onready var trade_ui: TradeUI = $TradeUI


var goods_data:Array[Dictionary]


func _ready() -> void:
	load_csv("res://goods_data_table.csv")
	print(goods_data)



func Trace(t_goods:TradeGoods):
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_A:
			trade_ui.reset_list_goods(player_trade_goods,$"../Sprite2D/TradeGoods")



func load_csv(csv_path:String):
	var csv_file
	var items_title:PackedStringArray

	if FileAccess.file_exists(csv_path):
		csv_file = FileAccess.open(csv_path,FileAccess.READ)
		items_title = csv_file.get_csv_line(",")

		while csv_file.get_position()<csv_file.get_length():
			var csv_item:PackedStringArray = csv_file.get_csv_line(",")
			var item:Dictionary
			for title in items_title.size():
				if title == 0:
					item[items_title[title]] = csv_item[title].to_int()
				elif title == 2:
					item[items_title[title]] = csv_item[title].to_float()
				else:
					item[items_title[title]] = csv_item[title]
			goods_data.append(item)
		csv_file.close()

func get_goods_name(id:int):
	return goods_data.filter(func(gd):return gd["id"]==id)[0]["name"]

func get_goods_price(id:int):
	return goods_data.filter(func(gd):return gd["id"]==id)[0]["price"]
