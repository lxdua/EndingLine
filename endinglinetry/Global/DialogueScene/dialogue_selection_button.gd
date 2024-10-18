extends Button

var button_text: String
var aim_id: String

@onready var dialogue_scene: CanvasLayer = $"../../../../../../.."

func _ready() -> void:
	text = button_text

func _on_pressed() -> void:
	dialogue_scene.update_dialogue(aim_id)
