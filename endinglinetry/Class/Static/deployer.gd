extends Node
class_name Deployer


static var station_list: Dictionary = {
	StationScene.StationType.RUINS: [

	],
	StationScene.StationType.CITY: [

	],
	StationScene.StationType.VILLAGE: [

	],
	StationScene.StationType.GATHER_POINT: [

	],
	StationScene.StationType.BEACON: [

	],
	StationScene.StationType.CAVE: [

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
	return station_array[randi_range(0, station_array.size()-1)]
