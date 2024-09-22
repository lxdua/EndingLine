class_name TradeGoodsStruct
var id:int=0
var number:int=0
var price_multiplier:float=1

func set_goods(g_id:int,g_number:int,g_price_multiplier:float=price_multiplier):
	id=g_id
	number=g_number
	price_multiplier=g_price_multiplier

func print_goods():
	print("id:",id)
	print("数量:",number)
	print("价格倍率:",price_multiplier)
