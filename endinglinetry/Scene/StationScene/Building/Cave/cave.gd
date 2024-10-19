extends Building
class_name Cave

## 奖励池 不用再记权重了 权重是多少就放几个进池子然后等可能选就是一样的效果了
@export var treasure_pool: Array[int]
@export var item_num: int = 1

func press_building():
	print("Cave!")
	var treasure: = []
	for i in range(item_num):
		treasure.append(random_treasure())
	# TODO 放背包，显示获得奖励界面

func random_treasure():
	var rand_num: = randi_range(0, treasure_pool.size())
	return treasure_pool[rand_num]
