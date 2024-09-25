extends Node
class_name TrainStatsManager


var max_power: int
var current_power: int:
	set(v):
		current_power = clamp(v, 0, max_power)

var max_train_load: int
var current_train_load: int:
	set(v):
		current_train_load = clamp(v, 0, max_train_load)

var max_speed: int
var current_speed: int:
	set(v):
		current_speed = clamp(v, 0, max_speed)

var solar_panel_efficiency: int

func get_solar_power():
	pass
