extends PanelContainer

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var tip_label: Label = $VBoxContainer/TipLabel

@onready var cost_label: Label = $VBoxContainer/CostLabel

func update_content(station: Station, distance: float):
	match station.station_type:
		Station.StationType.CITY:
			name_label.text = "都市"
		Station.StationType.VILLAGE:
			name_label.text = "村庄"
		Station.StationType.GATHER_POINT:
			name_label.text = "采集点"
		Station.StationType.BEACON:
			name_label.text = "哨站"
		Station.StationType.RUINS:
			name_label.text = "废墟"
		Station.StationType.CAVE:
			name_label.text = "洞穴"
	if distance == INF:
		cost_label.text = "无法到达"
	else:
		cost_label.text = "距离" + str(distance) + "m"
