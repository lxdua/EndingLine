extends Node
class_name MaptxtReader

static func read_map_from_txt(txt_file: String):
	# 第一行一个数字n，表示一共n个station
	# 接下来n行，每行两个数字用逗号分隔，分别表示第i个station的xy坐标
	# 接下来n行，每行（），表示第i个station的类型
	# 接下来一个数字m，表示m条有向边
	# 接下来m行，每行三个数字用空格分隔，分别表示第i条track的起点station编号、终点station编号、路程
	var txt = FileAccess.open(txt_file, FileAccess.READ)

	var station_pos_arr: Array[Vector2] = []
	var station_type_arr: Array[int] = []
	var track_arr: Array[Vector3i] = []

	print("读取txt地图中......")

	var n: = int(txt.get_line())
	for i in range(n):
		var line: = txt.get_line().split(",")
		var pos: = Vector2(int(line[0]),int(line[1]))
		station_pos_arr.append(pos)
		print("第", i, "个车站在", pos)
	for i in range(n):
		var type: = int(txt.get_line())

	var m: = int(txt.get_line())
	for i in range(m):
		var line: = txt.get_line().split(" ")
		var st: = int(line[0])
		var ed: = int(line[1])
		var len: = int(line[2])
		track_arr.append(Vector3i(st,ed,len))

	var map_dict: Dictionary = {}
	map_dict["station_pos_arr"] = station_pos_arr
	map_dict["station_type_arr"] = station_type_arr
	map_dict["track_arr"] = track_arr
	return map_dict
