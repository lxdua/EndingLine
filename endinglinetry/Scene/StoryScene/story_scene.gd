extends CanvasLayer

@export var speed: float = 10.0
@export var title: String
@export_multiline var article_text: Array[String]

@onready var title_label: Label = $TitleLabel
@onready var article_container: VBoxContainer = $ArticleContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var ori_text_label: Label = $TextLabel

var finished: bool = false

func _ready() -> void:
	title_label.text = title
	DialogueScene.dialogue_end.connect(end)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if not finished:
			next()

func next():
	if article_text.is_empty():
		talk()
		animation_player.play("end")
		finished = true
		return
	var new_text: String = article_text.pop_front()
	if new_text == "#clear":
		for label in article_container.get_children():
			label.queue_free()
		next()
		return
	var text_label: = ori_text_label.duplicate()
	text_label.text = new_text
	article_container.add_child(text_label)
	var tween: = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1, new_text.length()/speed).from(0)

func talk():
	DialogueScene.show_dialogue("A1")

func end():
	CurtainLayer.curtain_change_scene("res://Scene/PrisonScene/prison_scene.tscn")
