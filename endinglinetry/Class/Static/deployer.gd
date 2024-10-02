extends Node
class_name Deployer


static var station_res_list: Dictionary = {
	StationRes.StationType.RUINS: [
		preload("res://Resource/StationRes/Ruins/原爆点.tres"),
		preload("res://Resource/StationRes/Ruins/多米诺废墟.tres"),
		preload("res://Resource/StationRes/Ruins/奥斯维辛.tres"),
	],
	StationRes.StationType.CITY: [
		preload("res://Resource/StationRes/City/挪威格伦.tres"),
		preload("res://Resource/StationRes/City/斯德哥尔摩.tres"),
	],
	StationRes.StationType.VILLAGE: [
		preload("res://Resource/StationRes/Village/埃利迪.tres"),
	],
	StationRes.StationType.GATHER_POINT: [
		preload("res://Resource/StationRes/GatherPoint/雨崩.tres"),
	],
	StationRes.StationType.BEACON: [
		preload("res://Resource/StationRes/Beacon/维京人.tres"),
	],
	StationRes.StationType.CAVE: [
		preload("res://Resource/StationRes/Cave/哀嚎洞窟.tres")
	],
}

static func deploy_station(degree: int) -> StationRes:
	var station_type: StationRes.StationType
	if degree == 1:
		var rand_num = randi_range(1, 30+20+50)
		if rand_num <= 30:
			station_type = StationRes.StationType.GATHER_POINT
		elif rand_num <= 30+20:
			station_type = StationRes.StationType.RUINS
		elif rand_num <= 30+20+50:
			station_type = StationRes.StationType.CAVE
	elif degree == 2:
		var rand_num = randi_range(1, 50+20+15+15)
		if rand_num <= 50:
			station_type = StationRes.StationType.VILLAGE
		elif rand_num <= 50+20:
			station_type = StationRes.StationType.GATHER_POINT
		elif rand_num <= 50+20+15:
			station_type = StationRes.StationType.BEACON
		elif rand_num <= 50+20+15+15:
			station_type = StationRes.StationType.RUINS
	elif degree >= 3:
		var rand_num = randi_range(1, 50+5+25+20)
		if rand_num <= 50:
			station_type = StationRes.StationType.CITY
		elif rand_num <= 50+5:
			station_type = StationRes.StationType.GATHER_POINT
		elif rand_num <= 50+5+25:
			station_type = StationRes.StationType.BEACON
		elif rand_num <= 50+5+25+20:
			station_type = StationRes.StationType.RUINS
	var station_array = station_res_list[station_type]
	return station_array[randi_range(0, station_array.size()-1)]
