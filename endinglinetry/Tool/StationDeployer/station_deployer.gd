extends Node
class_name StationDeployer

const STATION_SCENE = preload("res://Scene/StationScene/station_scene.tscn")

const STATION_LIST: Dictionary = {
	StationScene.StationType.RUINS: preload("res://Resource/StationScene/RuinsSheet.json").data["data"],
	StationScene.StationType.CITY: preload("res://Resource/StationScene/CitySheet.json").data["data"],
	StationScene.StationType.VILLAGE: preload("res://Resource/StationScene/VillageSheet.json").data["data"],
	StationScene.StationType.GATHER_POINT: preload("res://Resource/StationScene/GatherPointSheet.json").data["data"],
	StationScene.StationType.BEACON: preload("res://Resource/StationScene/BeaconSheet.json").data["data"],
	StationScene.StationType.CAVE: preload("res://Resource/StationScene/CaveSheet.json").data["data"],
}

func deploy_station(degree: int) -> StationScene:
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
	var station_array: Array = STATION_LIST[station_type]
	print(station_array)
	var station_scene: = STATION_SCENE.instantiate()
	var station_dict: Dictionary = station_array[randi_range(0, station_array.size()-1)]
	station_scene.update_station_by_dict(station_type, station_dict)
	return station_scene
