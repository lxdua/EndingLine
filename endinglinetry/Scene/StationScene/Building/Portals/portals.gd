extends Building
class_name Portals

func press_building():
	print("Portals!")
	settle()

@onready var settlement_layer: CanvasLayer = $SettlementLayer

func settle():
	settlement_layer.show()
