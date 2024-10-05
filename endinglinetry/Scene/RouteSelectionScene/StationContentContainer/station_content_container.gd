extends PanelContainer

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var type_label: Label = $VBoxContainer/TypeLabel
@onready var tip_label: Label = $VBoxContainer/TipLabel

@onready var cost_label: Label = $VBoxContainer/CostLabel

func update_content(station_scene: StationScene, distance: float):
	name_label.text = station_scene.station_name
	match station_scene.station_type:
		StationScene.StationType.CITY:
			type_label.text = "都市"
		StationScene.StationType.VILLAGE:
			type_label.text = "村庄"
		StationScene.StationType.GATHER_POINT:
			type_label.text = "采集点"
		StationScene.StationType.BEACON:
			type_label.text = "哨站"
		StationScene.StationType.RUINS:
			type_label.text = "废墟"
		StationScene.StationType.CAVE:
			type_label.text = "洞穴"
	if distance == INF:
		cost_label.text = "无法到达"
	else:
		cost_label.text = "距离" + str(distance) + "m"
