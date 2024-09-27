extends Node2D
class_name BuildableTrack

var start_station: Station
var end_station: Station
var track_length: int
var cost: int

@onready var route_selection: RouteSelectionScene = $"../../.."

@onready var buildable_track_line: Line2D = $BuildableTrackLine
@onready var buildable_track_area: Area2D = $BuildableTrackArea
@onready var buildable_track_collision_shape: CollisionShape2D = $BuildableTrackArea/BuildableTrackCollisionShape
@onready var buildable_track_arrow: Polygon2D = $BuildableTrackArrow

func _ready() -> void:
	init_track()

func _on_buildable_track_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		if route_selection.current_station_id != start_station.station_id:
			return
		route_selection.try_to_build(self)

func init_track():
	global_position = start_station.station_position
	var dist: = end_station.station_position - start_station.station_position
	dist *= 1.0 - 32.0 / dist.length()
	buildable_track_line.add_point(Vector2.ZERO)
	buildable_track_line.add_point(dist)
	buildable_track_arrow.position = dist
	buildable_track_arrow.rotation = dist.angle()
	var new_shape = RectangleShape2D.new()
	new_shape.size.y = buildable_track_line.width
	new_shape.size.x = dist.length()
	buildable_track_collision_shape.shape = new_shape
	buildable_track_collision_shape.position.x += dist.length() / 2
	buildable_track_area.rotation = dist.angle()
