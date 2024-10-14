extends Node
class_name BuffHandler

var BUFF_DICT: Dictionary = {

}

signal buff_update

func has_buff(buff_name: String) -> bool:
	for buff: Buff in get_children():
		if buff.buff_name == buff_name:
			return true
	return false

func get_buff(buff_name: String):
	for buff: Buff in get_children():
		if buff.buff_name == buff_name:
			return buff
	return null

func add_buff(buff_name: String):
	if not BUFF_DICT.has(buff_name):
		return
	if get_buff(buff_name) ==	null:
		var new_buff: Buff = BUFF_DICT[buff_name].instantiate()
		add_child(new_buff)
	buff_update.emit()

func remove_buff(buff_name: String):
	for buff: Buff in get_children():
		if buff.buff_name == buff_name:
			buff.queue_free()
	buff_update.emit()

func clear_fitment():
	for buff: Buff in get_children():
		buff.queue_free()
	buff_update.emit()
