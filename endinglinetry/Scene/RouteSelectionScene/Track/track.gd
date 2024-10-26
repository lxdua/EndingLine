extends Node2D
class_name Track

var start_station: Station
var end_station: Station
var track_length: int

@onready var route_selection: RouteSelectionScene = $"../../.."

@onready var track_line: Line2D = $TrackLine
@onready var track_area: Area2D = $TrackArea
@onready var track_collision_shape: CollisionShape2D = $TrackArea/TrackCollisionShape

func _ready() -> void:
	init_track()

func _on_track_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		if route_selection.current_station_id != start_station.station_id:
			return
		route_selection.destination_id = end_station.station_id
		print(start_station.station_id, " ", end_station.station_id, " ", track_length)

func init_track():
	global_position = start_station.station_position
	var dist: = end_station.station_position - start_station.station_position
	dist *= 1.0 - 32.0 / dist.length()
	track_line.add_point(Vector2.ZERO)
	track_line.add_point(dist)
	var new_shape = RectangleShape2D.new()
	new_shape.size.y = track_line.width + 2
	new_shape.size.x = dist.length()
	track_collision_shape.shape = new_shape
	track_collision_shape.position.x += dist.length() / 2
	track_area.rotation = dist.angle()
