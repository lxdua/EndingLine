extends Node2D

const STATION: = preload("res://Scene/RouteSelectionScene/Station/station.tscn")
const TRACK: = preload("res://Scene/RouteSelectionScene/Track/track.tscn")

const MAX_STATION_NUM: = 5
const MAX_TRACK_LENGTH: = 100000

@export var map_res: MapRes

## 存站台
var station_dict: Dictionary
## 站台下标统计
var idx: int = 0

@onready var track_root: Node2D = $TrackRoot
@onready var station_root: Node2D = $StationRoot
@onready var train: Node2D = $Train

func _ready() -> void:
	init_floyd()
	create_map()

func create_map():
	var station_pos_list = map_res.station_pos_list
	for pos in station_pos_list:
		add_station(pos)
	var track_list = map_res.track_list
	for track in track_list:
		add_track(station_dict[track.x], station_dict[track.y], track.z)

func add_station(station_position: Vector2):
	var new_station: = STATION.instantiate()
	new_station.station_id = idx
	new_station.station_position = station_position
	station_dict[idx] = new_station
	station_root.add_child(new_station)
	idx += 1

func remove_station(station: Station):
	station_dict.erase(station.station_id)
	station.queue_free()

func add_track(start_station: Station, end_station: Station, track_length: int):
	var new_track: = TRACK.instantiate()
	new_track.start_station = start_station
	new_track.end_station = end_station
	new_track.track_length = track_length
	track_root.add_child(new_track)
	update_track(start_station, end_station, track_length)

func remove_track(track: Track):
	track.queue_free()
	update_track(track.start_station, track.end_station, MAX_TRACK_LENGTH)

func update_track(start_station: Station, end_station: Station, track_length: int):
	matrix[start_station.station_id][end_station.station_id] = min(matrix[start_station.station_id][end_station.station_id], track_length)
	update_floyd(start_station.station_id)
	update_floyd(end_station.station_id)

var matrix: Array[Array]
var mid_station: Array[Array]
var shortest_path: Array[int]

func init_floyd(n: int = MAX_STATION_NUM):
	matrix.clear()
	for i in range(n):
		matrix.append([])
		mid_station.append([])
		for j in range(n):
			matrix[i].append(MAX_TRACK_LENGTH)
			mid_station[i].append(-1)
	for i in range(n):
		matrix[i][i] = 0

func update_floyd(k: int, n: int = MAX_STATION_NUM):
	for x in range(n):
		for y in range(n):
			if matrix[x][y] > matrix[x][k] + matrix[k][y]:
				matrix[x][y] = matrix[x][k] + matrix[k][y]
				mid_station[x][y] = k

func get_shortest_path(start_station: Station, end_station: Station):
	shortest_path.clear()
	calc_mid(start_station.station_id, end_station.station_id)

func calc_mid(x: int, y: int):
	if x == y:
		return
	var k = mid_station[x][y]
	if k == -1:
		shortest_path.append(y)
	else:
		calc_mid(x, k)
		calc_mid(k, y)
