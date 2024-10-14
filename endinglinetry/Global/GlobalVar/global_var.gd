extends Node

signal time_scale_update
var time_scale: float = 1.0:
	set(v):
		time_scale = v
		time_scale_update.emit()
