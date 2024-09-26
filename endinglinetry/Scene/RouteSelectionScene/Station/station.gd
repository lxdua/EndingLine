extends Node2D
class_name Station

enum StationType { RUINS, CITY, VILLAGE, GATHER_POINT, BEACON, CAVE }

var station_id: int
var station_position: Vector2
var station_type: StationType
var station_connected_track: Array[Track] = []

@onready var route_selection: RouteSelectionScene = $"../../.."

func _ready() -> void:
	global_position = station_position

#region 部署相关

func deploy_station():
	var degree: = station_connected_track.size()
	var rand_num: int = -1
	if degree == 1:
		rand_num = randi_range(1, 30+20+50)
		if rand_num <= 30:
			station_type = StationType.GATHER_POINT
		elif rand_num <= 30+20:
			station_type = StationType.RUINS
		elif rand_num <= 30+20+50:
			station_type = StationType.CAVE
	elif degree == 2:
		rand_num = randi_range(1, 50+20+15+15)
		if rand_num <= 50:
			station_type = StationType.VILLAGE
		elif rand_num <= 50+20:
			station_type = StationType.GATHER_POINT
		elif rand_num <= 50+20+15:
			station_type = StationType.BEACON
		elif rand_num <= 50+20+15+15:
			station_type = StationType.RUINS
	elif degree >= 3:
		rand_num = randi_range(1, 50+5+25+20)
		if rand_num <= 50:
			station_type = StationType.CITY
		elif rand_num <= 50+5:
			station_type = StationType.GATHER_POINT
		elif rand_num <= 50+5+25:
			station_type = StationType.BEACON
		elif rand_num <= 50+5+25+20:
			station_type = StationType.RUINS
	print("抽取", rand_num, station_type)

#endregion

#region UI交互相关

func _on_station_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		route_selection.destination_id = station_id

#endregion
