extends Building
class_name GatherPoint

# 物品名和对应数量的下标相同
var item_arr: Array
var item_num_arr: Array

func press_building():
	print(item_arr)
	print(item_num_arr)
	# TODO 打开采集点界面
	pass

func _ready() -> void:
	# TODO 用上面的信息更新
	pass
