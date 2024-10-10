extends Building
class_name Portals

func press_building():
	print("Portals!")
	back_to_the_prison()

func back_to_the_prison():
	CurtainLayer.curtain_change_scene("res://Scene/PrisonScene/prison_scene.tscn", "少女回家中。。。")
