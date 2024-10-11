extends Node
class_name StationDeployer


static var station_list: Dictionary = {
	StationScene.StationType.RUINS: [
		preload("res://Resource/StationScene/Ruins/原爆点.tscn"),
		preload("res://Resource/StationScene/Ruins/多米诺废墟.tscn"),
		preload("res://Resource/StationScene/Ruins/奥斯维辛.tscn"),
	],
	StationScene.StationType.CITY: [
		preload("res://Resource/StationScene/City/挪威格伦.tscn"),
		preload("res://Resource/StationScene/City/斯德哥尔摩.tscn"),
	],
	StationScene.StationType.VILLAGE: [
		preload("res://Resource/StationScene/Village/埃利迪.tscn"),
	],
	StationScene.StationType.GATHER_POINT: [
		preload("res://Resource/StationScene/GatherPoint/雨崩.tscn"),
	],
	StationScene.StationType.BEACON: [
		preload("res://Resource/StationScene/Beacon/维京人.tscn"),
	],
	StationScene.StationType.CAVE: [
		preload("res://Resource/StationScene/Cave/哀嚎洞窟.tscn"),
	],
}

static func deploy_station(degree: int) -> StationScene:
	var station_type: StationScene.StationType
	if degree == 1:
		var rand_num = randi_range(1, 30+20+50)
		if rand_num <= 30:
			station_type = StationScene.StationType.GATHER_POINT
		elif rand_num <= 30+20:
			station_type = StationScene.StationType.RUINS
		elif rand_num <= 30+20+50:
			station_type = StationScene.StationType.CAVE
	elif degree == 2:
		var rand_num = randi_range(1, 50+20+15+15)
		if rand_num <= 50:
			station_type = StationScene.StationType.VILLAGE
		elif rand_num <= 50+20:
			station_type = StationScene.StationType.GATHER_POINT
		elif rand_num <= 50+20+15:
			station_type = StationScene.StationType.BEACON
		elif rand_num <= 50+20+15+15:
			station_type = StationScene.StationType.RUINS
	elif degree >= 3:
		var rand_num = randi_range(1, 50+5+25+20)
		if rand_num <= 50:
			station_type = StationScene.StationType.CITY
		elif rand_num <= 50+5:
			station_type = StationScene.StationType.GATHER_POINT
		elif rand_num <= 50+5+25:
			station_type = StationScene.StationType.BEACON
		elif rand_num <= 50+5+25+20:
			station_type = StationScene.StationType.RUINS
	var station_array = station_list[station_type]
	var station_packed_scene: PackedScene = station_array[randi_range(0, station_array.size()-1)]
	return station_packed_scene.instantiate()
