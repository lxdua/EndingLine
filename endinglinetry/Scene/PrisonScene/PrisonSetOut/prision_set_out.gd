extends Interaction

@export_file("*.tscn") var base_scene: String

func interact(player_body: PlayerBody):
	CurtainLayer.curtain_change_scene(base_scene, "少女祈祷中。。。")
