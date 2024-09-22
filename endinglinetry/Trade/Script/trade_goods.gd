extends Node
class_name TradeGoods


@export_category("添加货物")
@export var add_id:int
@export var add_number:int
@export var add_g:bool:
	set(new_add):
		add_goods(add_id,add_number)
		add_g=false
@export_category("设置货物价格倍率")
@export var set_id:int
@export var set_multiplier:float=1
@export var set_g:bool:
	set(new_set):
		set_goods_price_multiplier(set_id,set_multiplier)
		set_g=false

@export_category("设置现金")
@export_range(0,99999) var cash:int


var goods:Array[TradeGoodsStruct]




func add_goods(id:int,number:int):
	var g:=TradeGoodsStruct.new()
	g.set_goods(id,number)
	var gg=goods.filter(func(g0):return g0.id==g.id)
	if gg:
		gg[0].number+=g.number
	else:
		goods.append(g)
	goods.any(func(g0):g0.print_goods())


func set_goods_price_multiplier(id:int,multiplier:float):
	if goods.any(func(gg):
		if gg.id==id:
			gg.price_multiplier=multiplier
			gg.print_goods()
			return true
		else:
			return false
	):
		print("设置成功")
	else:
		print("设置失败")
