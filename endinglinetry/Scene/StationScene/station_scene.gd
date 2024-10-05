extends Node3D
class_name StationScene

enum StationType { RUINS, CITY, VILLAGE, GATHER_POINT, BEACON, CAVE }

@export var station_name: String
@export var station_type: StationType
@export_multiline var station_description: String
