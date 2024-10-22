extends Building
class_name Cave

## 奖励池 不用再记权重了 权重是多少就放几个进池子然后等可能选就是一样的效果了
var item_pool: Array

var item_num: int = 1

func press_building():
	print("Cave!")
	# 点开的时候才进行抽取
	var treasure: Array[String] = []
	for i in range(item_num):
		treasure.append(random_treasure())
	# TODO 最后展示的就是treasure
	print(treasure)

func random_treasure():
	var rand_num: = randi_range(0, item_pool.size())
	return item_pool[rand_num]
