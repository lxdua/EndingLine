extends Node2D

const STATION: = preload("res://Scene/RouteSelectionScene/Station/station.tscn")
const TRACK: = preload("res://Scene/RouteSelectionScene/Track/track.tscn")

const MAX_STATION_NUM: = 100

@export var map_res: MapRes

## 存站台
var station_dict: Dictionary
## 站台下标统计
var idx: int = 0

@onready var track_root: Node2D = $TrackRoot
@onready var station_root: Node2D = $StationRoot
@onready var train: Node2D = $Train

func _ready() -> void:
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
	update_track(track.start_station, track.end_station, INF)

func update_track(start_station: Station, end_station: Station, track_length: int):
	matrix[start_station.station_id][end_station.station_id] = track_length
	update_floyd(start_station.station_id, idx)
	update_floyd(end_station.station_id, idx)

## 邻接矩阵
var matrix: Array[Array]
var ShortestPath: Array[int]
var pre: Array[Array]

func init_floyd(n: int = MAX_STATION_NUM):
	matrix.clear()
	var tmp_matrix: = []
	var tmp_pre: = []
	for i in range(n):
		tmp_matrix.append(INF)
		tmp_pre.append(-1)
	for i in range(n):
		matrix.append(tmp_matrix)
		pre.append(tmp_pre)
	for i in range(n):
		matrix[i][i] = 0

func calc_floyd(n: int = MAX_STATION_NUM):
	for k in range(n):
		for x in range(n):
			for y in range(n):
				if matrix[x][y] > matrix[x][k] + matrix[k][y]:
					matrix[x][y] = matrix[x][k] + matrix[k][y]
					pre[x][y] = k

func update_floyd(k: int, n: int = MAX_STATION_NUM):
	for x in range(n):
		for y in range(n):
			if matrix[x][y] > matrix[x][k] + matrix[k][y]:
				matrix[x][y] = matrix[x][k] + matrix[k][y]
				pre[x][y] = k
