extends Interaction

var player_body: PlayerBody

func interact(body: PlayerBody):
	DialogueScene.dialogue_end.connect(_on_dialogue_end)
	player_body = body
	body.can_move = false
	DialogueScene.show_dialogue("A1001")

func _on_dialogue_end():
	if player_body:
		player_body.can_move = true
		player_body = null
