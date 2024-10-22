extends Node2D
class_name Station

var station_id: int
var station_position: Vector2
var station_connected_track: Array[Track] = []

var station_scene: StationScene

@onready var route_selection: RouteSelectionScene = $"../../.."

func _ready() -> void:
	global_position = station_position

#region 部署相关

func deploy_station():
	var degree: = station_connected_track.size()
	var station_deployer: StationDeployer = StationDeployer.new()
	station_scene = station_deployer.deploy_station(degree)
	print("dep:", station_scene.station_dict)

#endregion

#region UI交互相关

func _on_station_texture_button_pressed() -> void:
	route_selection.destination_id = station_id

#endregion
