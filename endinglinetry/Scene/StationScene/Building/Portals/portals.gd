extends Building
class_name Portals

func press_building():
	print("Portals!")
	settlement.show_settlement()

@onready var settlement: CanvasLayer = $Settlement
