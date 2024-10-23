extends Building
class_name GatherPoint

@onready var base_scene: BaseScene = get_tree().get_first_node_in_group("BaseScene")
@onready var trade_manage:TradeManage = get_tree().get_first_node_in_group("TradeManage")

# 物品名和对应数量的下标相同
var item_arr: Array
var item_num_arr: Array

var resouces:Array[CollectionResource]
var last_day:int=0
func press_building():
	print(item_arr)
	print(item_num_arr)
	print("clock:",base_scene.date,"hour:",base_scene.hour)
	if base_scene.date>last_day and base_scene.hour>=6:
		last_day=base_scene.clock
		update_resouces()
	trade_manage.open_collection_ui(resouces)
	pass

func update_resouces():
	resouces.clear()
	for i in range(item_arr.size()):
		var r:CollectionResource = CollectionResource.new()
		r.id=trade_manage.get_goods_id_by_name(item_arr[i])
		r.number=item_num_arr[i]
		resouces.append(r)

func _ready() -> void:
	update_resouces()
	pass
