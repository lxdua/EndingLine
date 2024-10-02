extends Node2D
class_name Station

var station_id: int
var station_position: Vector2
var station_connected_track: Array[Track] = []

var station_res: StationRes

@onready var route_selection: RouteSelectionScene = $"../../.."

func _ready() -> void:
	global_position = station_position

#region 部署相关

func deploy_station():
	var degree: = station_connected_track.size()
	station_res = Deployer.deploy_station(degree)

#endregion

#region UI交互相关

func _on_station_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		route_selection.destination_id = station_id

#endregion
