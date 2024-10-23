extends Building
class_name GatherPoint

@onready var base_scene: BaseScene = get_tree().get_first_node_in_group("BaseScene")
@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")
@onready var trade_manage:TradeManage = get_tree().get_first_node_in_group("TradeManage")

# 物品名和对应数量的下标相同
var item_arr: Array
var item_num_arr: Array

var resouces:Array[CollectionResource]

var last_visit_time: int

func shold_update():
	var base_scene: BaseScene = get_tree().get_first_node_in_group("BaseScene")
	var d_time: = base_scene.current_time - last_visit_time
	if d_time >= 1440:
		return true
	var last_visit_date: = last_visit_time / 1440
	var last_visit_clock: = last_visit_time - last_visit_date * 1440
	var current_clock = base_scene.clock
	if (last_visit_clock <= 6 and 6 <= current_clock) or (current_clock <= 6 and 6 <= last_visit_clock):
		return true
	return false

func press_building():
	print(item_arr)
	print(item_num_arr)
	print("clock:",base_scene.date,"hour:",base_scene.hour)
	if shold_update():
		update_resouces()
	trade_manage.open_collection_ui(resouces)

func update_resouces():
	resouces.clear()
	for i in range(item_arr.size()):
		var r:CollectionResource = CollectionResource.new()
		r.id=trade_manage.get_goods_id_by_name(item_arr[i])
		r.number = train_stats_manager.get_gather_output(item_num_arr[i])
		resouces.append(r)
