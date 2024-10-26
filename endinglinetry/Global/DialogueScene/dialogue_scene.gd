extends CanvasLayer

const DIALOGUE_RES = preload("res://Resource/Dialogue/Dialogue.json")
const SELECTION_RES = preload("res://Resource/Dialogue/Selection.json")

const DIALOGUE_SELECTION_BUTTON = preload("res://Global/DialogueScene/dialogue_selection_button.tscn")

const TEXTURE_DICT = {
	"Aki": preload("res://Art/2D/Player/Dialogue/AkiPic.png"),
	"Ruu": preload("res://Art/2D/Player/Dialogue/RuuPic.png"),
}

## 打字机速度 多少个字每秒
@export var typewriter_speed: float = 20.0

@export var dialogue_ui_root: Control
@export var role_name_label: Label
@export var content_label: Label

@export var selection_container: VBoxContainer

@export var role_l: TextureRect
@export var role_m: TextureRect
@export var role_r: TextureRect

var dialogue_dict: Dictionary
var selection_dict: Dictionary

var current_id: String
var current_role: String
var content_tween: Tween

var need_to_select: bool = false

signal dialogue_end

## 从对应编号对话开始
func show_dialogue(id: String):
	update_dialogue(id)
	show()

func _ready() -> void:
	hide()
	read_json()

func _unhandled_input(event: InputEvent) -> void:
	if visible == false:
		return
	if need_to_select:
		return
	if event.is_action_pressed("ui_accept"):
		if content_tween.is_running():
			show_remaining_content()
		else:
			update_dialogue(str(dialogue_dict[current_id]["next_id"]).strip_edges())

func read_json():
	dialogue_dict.clear()
	for dict in DIALOGUE_RES.data["data"]:
		dialogue_dict[dict["id"]] = dict
	selection_dict.clear()
	for dict in SELECTION_RES.data["data"]:
		selection_dict[dict["id"]] = dict

#region 对话部分

func show_remaining_content():
	content_tween.kill()
	content_label.visible_ratio = 1.0

func update_dialogue(id: String):
	current_id = id.strip_edges()
	need_to_select = false
	selection_container.hide()
	if current_id == "END":
		hide()
		dialogue_end.emit()
	elif current_id.left(1) == "#":
		need_to_select = true
		update_selection(selection_dict[current_id.right(-1)]["content"])
		update_effect(selection_dict[current_id.right(-1)]["effect"])
	else:
		update_role(dialogue_dict[current_id]["role"])
		update_content(dialogue_dict[current_id]["content"])
		update_effect(dialogue_dict[current_id]["effect"])

func update_role(role: String):
	current_role = role
	match role:
		"Aki":
			role_name_label.text = current_role
		"Ruu":
			role_name_label.text = current_role
		"None":
			role_name_label.text = ""

func update_content(content: String):
	content_label.text = content
	content_tween = content_label.create_tween()
	content_tween.tween_property(
		content_label,
		"visible_ratio",
		1.0, content.length() / typewriter_speed
		).from(0.0)

#endregion

#region 选择部分

func update_selection(content: String):
	clear_selection()
	var selection_arr: = content.split("|")
	for selection in selection_arr:
		add_button(selection)
	selection_container.show()

func add_button(selection: String):
	var new_button: = DIALOGUE_SELECTION_BUTTON.instantiate()
	new_button.button_text = selection.split("$")[0]
	new_button.aim_id = selection.split("$")[1]
	selection_container.add_child(new_button)

func clear_selection():
	for button in selection_container.get_children():
		button.queue_free()

#endregion

#region 效果部分

func update_effect(effect: String):
	clear_role()
	if effect == "None":
		return
	var effect_arr: = effect.split("|")
	for spell in effect_arr:
		unscramble_spell(spell)

func clear_role():
	role_l.texture = null
	role_m.texture = null
	role_r.texture = null
	role_l.flip_h = false
	role_m.flip_h = false
	role_r.flip_h = false
	role_l.modulate = Color.WHITE
	role_m.modulate = Color.WHITE
	role_r.modulate = Color.WHITE

func unscramble_spell(spell: String):
	var spell_arr: = spell.split("$")
	match spell_arr[0].strip_edges():
		"ROLE":
			var tex: Texture = null
			var aim_role_texr: TextureRect = null
			for word in spell_arr:
				word = word.strip_edges()
				match word:
					"Aki":
						tex = TEXTURE_DICT["Aki"]
					"Ruu":
						tex = TEXTURE_DICT["Ruu"]
					"L":
						aim_role_texr = role_l
					"M":
						aim_role_texr = role_m
					"R":
						aim_role_texr = role_r
					"IN":
						var tween: = aim_role_texr.create_tween()
						tween.tween_property(aim_role_texr, "modulate:a", 1.0, 0.3).from(0.0)
					"OUT":
						var tween: = aim_role_texr.create_tween()
						tween.tween_property(aim_role_texr, "modulate:a", 0.0, 0.3).from(1.0)
					"FLIP":
						aim_role_texr.flip_h = true
					"DARK":
						aim_role_texr.modulate = Color.DIM_GRAY
					"DARKIN":
						var tween: = aim_role_texr.create_tween()
						tween.tween_property(aim_role_texr, "modulate", Color.DIM_GRAY, 0.3).from(Color.WHITE)
					"DARKOUT":
						aim_role_texr.modulate = Color.DIM_GRAY
						var tween: = aim_role_texr.create_tween()
						tween.tween_property(aim_role_texr, "modulate", Color.WHITE, 0.3).from(Color.DIM_GRAY)
					"NOD":
						var tween: = aim_role_texr.create_tween().set_trans(Tween.TRANS_CUBIC)
						var c_pos: = aim_role_texr.position
						tween.tween_property(aim_role_texr, "position", c_pos + Vector2(0,24), 0.2).from(c_pos).set_ease(Tween.EASE_OUT)
						tween.tween_property(aim_role_texr, "position", c_pos, 0.2).from(c_pos + Vector2(0,24)).set_ease(Tween.EASE_IN)
					"SHAKE":
						pass
					"JUMP":
						var tween: = aim_role_texr.create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
						var c_pos: = aim_role_texr.position
						tween.tween_property(aim_role_texr, "position", c_pos, 0.6).from(c_pos + Vector2(0,-24))
					"EXJUMP":
						var tween: = aim_role_texr.create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
						var c_pos: = aim_role_texr.position
						tween.tween_property(aim_role_texr, "position", c_pos, 0.4).from(c_pos + Vector2(0,-48))
					"JUMPIN":
						var tween: = aim_role_texr.create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
						var c_pos: = aim_role_texr.position
						tween.tween_property(aim_role_texr, "position", c_pos, 0.6).from(c_pos + Vector2(0,500))
					"ANXIETY":
						pass
			if aim_role_texr and tex:
				aim_role_texr.texture = tex

#endregion
