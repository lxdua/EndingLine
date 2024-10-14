extends Node2D
class_name ParallaxBG

var orgin_autoscroll: Array

var is_stopped: bool

func _ready() -> void:
	GlobalVar.time_scale_update.connect(set_scroll_scale)
	for parallax: Parallax2D in get_children():
		orgin_autoscroll.append(parallax.autoscroll.x)

func set_scroll_scale():
	if is_stopped:
		return
	for i in get_child_count():
		var parallax: Parallax2D = get_child(i)
		parallax.autoscroll.x = orgin_autoscroll[i] * GlobalVar.time_scale

func stop_scroll():
	is_stopped = true
	for i in get_child_count():
		var parallax: Parallax2D = get_child(i)
		parallax.autoscroll.x = 0

func start_scroll():
	is_stopped = false
	for i in get_child_count():
		var parallax: Parallax2D = get_child(i)
		parallax.autoscroll.x = orgin_autoscroll[i] * GlobalVar.time_scale
