extends CanvasLayer


@onready var curtain_animation_player: AnimationPlayer = $CurtainAnimationPlayer
@export var curtain_tip_label: Label


func fade_in(tip: String = ""):
	curtain_tip_label.text = tip
	curtain_animation_player.play("curtain fade in")
	await curtain_animation_player.animation_finished

func fade_out():
	curtain_animation_player.play("curtain fade out")

func curtain_change_scene(file: String, tip: String = ""):
	curtain_tip_label.text = tip
	curtain_animation_player.play("curtain fade in")
	await curtain_animation_player.animation_finished
	get_tree().change_scene_to_file(file)
	await get_tree().create_timer(2.0).timeout
	curtain_animation_player.play("curtain fade out")
