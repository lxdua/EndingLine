extends PanelContainer

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var type_label: Label = $VBoxContainer/TypeLabel
@onready var tip_label: Label = $VBoxContainer/TipLabel

@onready var cost_label: Label = $VBoxContainer/CostLabel

func update_content(station_res: StationRes, distance: float):
	name_label.text = station_res.station_name
	match station_res.station_type:
		StationRes.StationType.CITY:
			type_label.text = "都市"
		StationRes.StationType.VILLAGE:
			type_label.text = "村庄"
		StationRes.StationType.GATHER_POINT:
			type_label.text = "采集点"
		StationRes.StationType.BEACON:
			type_label.text = "哨站"
		StationRes.StationType.RUINS:
			type_label.text = "废墟"
		StationRes.StationType.CAVE:
			type_label.text = "洞穴"
	if distance == INF:
		cost_label.text = "无法到达"
	else:
		cost_label.text = "距离" + str(distance) + "m"
