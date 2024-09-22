extends Node2D
class_name Station

var station_id: int
var station_position: Vector2

func _ready() -> void:
	global_position = station_position
