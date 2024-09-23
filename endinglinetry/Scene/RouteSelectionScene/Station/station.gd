extends Node2D
class_name Station

var station_id: int
var station_position: Vector2

@onready var route_selection: = get_parent().get_parent()

func _ready() -> void:
	global_position = station_position

func _on_station_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		route_selection.destination_id = station_id
