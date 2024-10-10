extends Node
class_name TradeGoods

@onready var trade_manage:TradeManage=get_tree().get_nodes_in_group("TradeManage")[0]

@export_category("添加货物")
@export var add_id:int
@export var add_number:int
@export var add_g:bool:
	set(new_add):
		add_goods(add_id,add_number)
		add_g=false
		if trade_manage:
			trade_manage.update_list_goods()
			trade_manage.back_pack_ui.update()
@export_category("设置货物价格倍率")
@export var set_id:int
@export var set_multiplier:float=1
@export var set_g:bool:
	set(new_set):
		set_goods_price_multiplier(set_id,set_multiplier)
		set_g=false
		if trade_manage:
			trade_manage.update_list_goods()
			trade_manage.back_pack_ui.update()

@export_category("设置现金")
@export_range(0,99999) var cash:int

@export_category("设置载重量")
@export_range(0,999999) var max_load:int=100

var goods:Array[TradeGoodsStruct]



func add_goods(id:int,number:int):
	var g:=TradeGoodsStruct.new()
	g.set_goods(id,number)
	var gg=goods.filter(func(g0):return g0.id==g.id)
	if gg:
		gg[0].number+=g.number
	else:
		goods.append(g)
	goods.any(func(g0):
		g0.trade_goods=self
		g0.print_goods()
		)


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

func find_goods(id:int)->TradeGoodsStruct:
	var g:TradeGoodsStruct
	var ga = goods.filter(func(gg):
		if gg.id==id:
			return true
		else:
			return false
	)
	if ga:
		g=ga[0]
	else:
		add_goods(id,0)
		g=find_goods(id)
	return g

func print_all_goods():
	goods.all(func(g):g.print_goods())

func get_current_load()->int:
	var current_load:int
	for g in goods:
		current_load+=trade_manage.get_goods_heavy(g.id)*g.number

	return current_load


var sort_type:int
func sort_goods(a:TradeGoodsStruct,b:TradeGoodsStruct)->bool:
	if sort_type==0:
		if a.id>b.id:
			return true
		else :
			return false
	elif sort_type==1:
		var a_l = trade_manage.get_goods_heavy(a.id)*a.number
		var b_l = trade_manage.get_goods_heavy(b.id)*b.number
		if a_l<b_l:
			return true
		else :
			return false
	elif sort_type==2:
		var a_p = trade_manage.get_goods_price(a.id)*a.number
		var b_p = trade_manage.get_goods_price(b.id)*b.number
		if a_p<b_p:
			return true
		else :
			return false
	else :
		return false

func goods_sort(type:int):
	sort_type=type
	goods.sort_custom(sort_goods)
