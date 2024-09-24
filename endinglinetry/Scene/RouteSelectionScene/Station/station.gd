extends Node2D
class_name Station

var station_id: int
var station_position: Vector2

@onready var route_selection: RouteSelectionScene = $"../../.."
@onready var content_container: PanelContainer = $ContentContainer

func _ready() -> void:
	global_position = station_position
	route_selection.destination_id_update.connect(on_destination_id_update)
	route_selection.ui_is_pressed.connect(on_ui_is_pressed)

func _on_station_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		route_selection.destination_id = station_id
		show_station_content()

func on_destination_id_update(id: int):
	if id == station_id:
		show_station_content()
	else:
		hide_station_content()

func on_ui_is_pressed():
	hide_station_content()

func show_station_content():
	content_container.show()

func hide_station_content():
	content_container.hide()
