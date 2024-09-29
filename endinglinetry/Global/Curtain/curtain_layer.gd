extends CanvasLayer


@onready var curtain_animation_player: AnimationPlayer = $CurtainAnimationPlayer
@export var curtain_tip_label: Label


func fade_in():
	curtain_animation_player.play("curtain fade in")

func fade_out():
	curtain_animation_player.play("curtain fade out")

func show_tip(tip: String):
	curtain_tip_label.text = tip
