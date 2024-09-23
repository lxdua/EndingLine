extends Node2D
class_name Track

var start_station: Station
var end_station: Station
var track_length: int

@onready var track_line: Line2D = $TrackLine
@onready var track_area: Area2D = $TrackArea
@onready var track_collision_shape: CollisionShape2D = $TrackArea/TrackCollisionShape

func _ready() -> void:
	global_position = start_station.station_position
	var dist: = end_station.station_position - start_station.station_position
	track_line.add_point(Vector2.ZERO)
	track_line.add_point(dist)
	var new_shape = RectangleShape2D.new()
	new_shape.size.y = track_line.width
	new_shape.size.x = dist.length()
	track_collision_shape.shape = new_shape
	track_collision_shape.position.x += dist.length() / 2
	track_area.rotation = dist.angle()


func _on_track_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		print(start_station.station_id, " ", end_station.station_id, " ", track_length)
