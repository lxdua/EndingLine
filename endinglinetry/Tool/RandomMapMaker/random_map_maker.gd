extends Node

const PLOTTING_SCALE: float = 1.0

@export_range(1, 50) var add_num: int = 10
@export_range(100, 5000) var max_dist: int = 1000

var station_sum: int

func make_random_map(sta_sum: int, seed_str: String):
	station_sum = sta_sum
	if seed_str != "":
		seed(seed_str.hash())
	else:
		seed_str = Time.get_time_string_from_system()
		seed(seed_str.hash())
		print(seed_str)
	make_station()
	sort_by_dist()
	make_track()
	make_track()
	make_buildable_track()
	return return_map_res()

func return_map_res():
	var map_res: MapRes = MapRes.new()
	for sta in sta_list:
		map_res.station_pos_list.append(sta.pos)
	for tra in tra_list:
		map_res.track_list.append([
			tra.st,
			tra.ed,
			(sta_list[tra.st].pos - sta_list[tra.ed].pos).length() * PLOTTING_SCALE,
			])

	return map_res

class _Station:
	var id: int
	var pos: Vector2
	func _init(id: int, pos: Vector2) -> void:
		self.id = id
		self.pos = pos

class _Track:
	var st: int
	var ed: int
	func _init(st: int, ed: int) -> void:
		self.st = st
		self.ed = ed

class _Buildable_Track:
	var st: _Station
	var ed: _Station

var sta_list: Array[_Station]
var tra_list: Array[_Track]
var bu_tra_list: Array[_Buildable_Track]

func make_station():
	for id in range(station_sum):
		var new_sta_arr = []
		for i in range(add_num):
			var new_sta_pos: Vector2i
			new_sta_pos.x = randi_range(-max_dist, max_dist)
			new_sta_pos.y = randf_range(-sqrt(max_dist * max_dist - new_sta_pos.x * new_sta_pos.x), sqrt(max_dist * max_dist - new_sta_pos.x * new_sta_pos.x))
			var mi_dist = INF
			for sta in sta_list:
				var dist = Vector2i(sta.pos) - new_sta_pos
				mi_dist = min(mi_dist, dist.length())
			new_sta_arr.append({
				"pos": new_sta_pos,
				"dist": mi_dist,
			})
		new_sta_arr.sort_custom(func(x: Dictionary, y: Dictionary):
			return x["dist"] > y["dist"]
		)
		var new_sta = _Station.new(id, new_sta_arr[0]["pos"])
		sta_list.append(new_sta)

func make_track():
	for i in range(station_sum):
		var id1: int = sta_list[i].id
		var id2: int = get_nearest_sta(i)
		add_track(id1, id2)
		sta_con.append([id1, id2])

func make_buildable_track():
	pass

var sta_sort_by_dist: Array[Array]
var sta_con: Array[Array]

func sort_by_dist():
	sta_sort_by_dist.clear()
	for sta1 in sta_list:
		sta_sort_by_dist.append([])
		for sta2 in sta_list:
			if sta1 == sta2:
				continue
			sta_sort_by_dist[sta1.id].append(sta2)
		sta_sort_by_dist[sta1.id].sort_custom(func(x: _Station, y: _Station):
			var dx: = (sta1.pos - x.pos).length()
			var dy: = (sta1.pos - y.pos).length()
			return dx < dy
		)

func get_nearest_sta(id: int):
	for s2 in sta_sort_by_dist[id]:
		if not sta_con.has([id, s2.id]) and not sta_con.has([s2.id, id]):
			return s2.id
	return null

func add_track(id1: int, id2: int):
	if not check_track(id1, id2):
		return
	tra_list.append(_Track.new(id1, id2))
	tra_list.append(_Track.new(id2, id1))

func check_track(id1: int, id2: int):
	var A: Vector2 = sta_list[id1].pos
	var B: Vector2 = sta_list[id2].pos
	var ab: Vector2 = B-A
	var ba: Vector2 = A-B
#region 检查交叉
	for tra in tra_list:
		var C: Vector2 = sta_list[tra.st].pos
		var D: Vector2 = sta_list[tra.ed].pos
		if max(C.x,D.x)<min(A.x,B.x) or max(C.y,D.y)<min(A.y,B.y) or max(A.x,B.x)<min(C.x,D.x) or max(A.y,B.y)<min(C.y,D.y):
			continue
		var cd: Vector2 = D - C
		var ca: Vector2 = A - C
		var cb: Vector2 = B - C
		var v1 = cd.cross(ca)
		var v2 = cd.cross(cb)
		if v1*v2 <= 0:
			if C==A or C==B or D==A or D==B:
				continue
			return false
#endregion

#region 检查角度
	for tra in tra_list:
		var pst: Vector2 = sta_list[tra.st].pos
		var ped: Vector2 = sta_list[tra.ed].pos
		var angle_bet
		if tra.st==id1:
			angle_bet = ab.angle_to(ped - pst)
		elif tra.ed==id1:
			angle_bet = ab.angle_to(pst - ped)
		elif tra.st==id2:
			angle_bet = ba.angle_to(pst - ped)
		elif tra.ed==id2:
			angle_bet = ba.angle_to(ped - pst)
		else:
			continue
		if abs(angle_bet) < PI/12.0:
			return false
#endregion

	return true
