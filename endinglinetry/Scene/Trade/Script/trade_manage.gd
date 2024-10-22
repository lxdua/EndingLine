extends Node2D
class_name TradeManage
@onready var player_trade_goods: TradeGoods = $PlayerTradeGoods
@onready var trade_ui: TradeUI = $TradeUI
@onready var back_pack_ui: BackPackUI = %BackPackUI


@export_range(0,1) var sell_multiplier:float=0.7

var goods_datas:Array[Dictionary]


func _ready() -> void:
	load_csv("res://goods_data_table.csv")
	print(goods_datas)


var trade_partner:TradeGoods
func open_trade_ui(t_goods:TradeGoods):
	#dua
	var train_stats_manager: = get_tree().get_first_node_in_group("TrainStatsManager")
	player_trade_goods.update_cash(train_stats_manager.current_money)

	trade_ui.goods_trade_details.visible=false
	trade_partner=t_goods
	update_list_goods()
	trade_ui.visible=true

func update_list_goods():
	if trade_partner:
		trade_ui.update_list_goods(player_trade_goods,trade_partner)



func Trade(trade_goods_struct:TradeGoodsStruct,number:int)->bool:
	var seller:TradeGoods = trade_goods_struct.trade_goods
	var amount:int
	if !seller:
		return false
	var buyer:TradeGoods
	if seller==player_trade_goods:
		buyer=trade_partner
		var gs = buyer.goods.filter(func(g):
				if g.id==trade_goods_struct.id:
					return true
				else:
					return false
		)
		if buyer.goods.is_empty() or !gs:
			amount = max(get_goods_price(trade_goods_struct.id)*trade_goods_struct.price_multiplier*sell_multiplier,1)*number
		else:
			amount = max(get_goods_price(gs[0].id)*gs[0].price_multiplier*sell_multiplier,1)*number

	else:
		buyer=player_trade_goods
		amount = max(get_goods_price(trade_goods_struct.id)*trade_goods_struct.price_multiplier,1)*number

	if trade_goods_struct.number>=number and buyer.cash>=amount:
		buyer.cash-=amount
		trade_goods_struct.number-=number
		if !buyer.goods.any(func(g):
			if g.id == trade_goods_struct.id:
				g.number+=number
				return true
			else:
				false
			):
				buyer.add_goods(trade_goods_struct.id,number)
		seller.cash+=amount
		return true
	else :
		return false



func open_back_pack_ui():
	back_pack_ui.trade_goods=player_trade_goods
	#dua
	var train_stats_manager: = get_tree().get_first_node_in_group("TrainStatsManager")
	player_trade_goods.update_cash(train_stats_manager.current_money)

	back_pack_ui.selected_item = null
	back_pack_ui.update()
	back_pack_ui.visible=true




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
				if title == 0 or title == 2 or title ==4:
					item[items_title[title]] = csv_item[title].to_int()
				else:
					item[items_title[title]] = csv_item[title]
			goods_datas.append(item)
		csv_file.close()

func get_goods_data(id:int)->Dictionary:
	return goods_datas.filter(func(gd):return gd["id"]==id)[0]

func get_goods_name(id:int)->String:
	return goods_datas.filter(func(gd):return gd["id"]==id)[0]["name"]

func get_goods_price(id:int)->int:
	return goods_datas.filter(func(gd):return gd["id"]==id)[0]["price"]

func get_goods_description(id:int)->String:
	return goods_datas.filter(func(gd):return gd["id"]==id)[0]["description"]

func get_goods_heavy(id:int)->int:
	return goods_datas.filter(func(gd):return gd["id"]==id)[0]["heavy"]

func get_goods_icon(id:int)->Texture2D:
	var icon:Texture2D = load("res://Art/2D/ItemIcon/"+str(id)+".png")
	return icon

func get_goods_id_by_name(name:String)->int:
	var ans = goods_datas.filter(func(gd):return gd["name"]==name)
	if ans.is_empty():
		print("cuozi", name)
		return -1
	# TODO 检测是否找到
	return ans[0].id
	#return goods_datas.filter(func(gd):return gd["name"]==name)[0].id
