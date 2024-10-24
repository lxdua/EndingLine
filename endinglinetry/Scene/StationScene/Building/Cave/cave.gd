extends Building
class_name Cave

@onready var modifier_handler: ModifierHandler = get_tree().get_first_node_in_group("ModifierHandler")
@onready var trade_manage:TradeManage = get_tree().get_first_node_in_group("TradeManage")
## 奖励池 不用再记权重了 权重是多少就放几个进池子然后等可能选就是一样的效果了
var item_pool: Array

var cave_item_num: int = 1:
	get:
		return modifier_handler.get_modifier_result_intelligently("cave_item_num", cave_item_num)

var is_open:bool = false
var treasure: Array[CollectionResource]

func press_building():
	print("Cave!")
	# 点开的时候才进行抽取
	if !is_open:
		for i in range(cave_item_num):
			var id = trade_manage.get_goods_id_by_name(random_treasure())
			var ts:Array[CollectionResource]=treasure.filter(func(t:CollectionResource):
				if t.id==id:
					return true
				else:
					return false
			)
			if ts:
				ts[0].number+=1
			else:
				var r:CollectionResource=CollectionResource.new()
				r.id=id
				r.number+=1
				treasure.append(r)
		print(treasure)
		is_open=true
	trade_manage.open_collection_ui(treasure)



func random_treasure():
	var rand_num: = randi_range(0, item_pool.size()-1)
	return item_pool[rand_num]
