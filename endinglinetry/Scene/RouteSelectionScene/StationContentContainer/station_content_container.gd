extends PanelContainer

@export var name_label: Label
@export var type_label: Label
@export var tip_label: Label
@export var cost_label: Label
@export var item_label: Label


func update_content(station_scene: StationScene, distance: float):
	name_label.text = station_scene.station_name
	tip_label.text = station_scene.station_tip
	item_label.text = ""
	match station_scene.station_type:
		StationScene.StationType.CITY:
			type_label.text = "都市"
			var dict: = station_scene.station_dict
			item_label.text = "税率：" + str(dict["tax_rate"]) + "%"
			item_label.text += "\n供应：" + dict["supply"]
			item_label.text += "\n需求：" + dict["demand"]
		StationScene.StationType.VILLAGE:
			type_label.text = "村庄"
			var dict: = station_scene.station_dict
			item_label.text = "税率：" + str(dict["tax_rate"]) + "%"
			item_label.text += "\n供应：" + dict["supply"]
			item_label.text += "\n需求：" + dict["demand"]
		StationScene.StationType.GATHER_POINT:
			type_label.text = "采集点"
			var dict: = station_scene.station_dict
			item_label.text = "可采集：" + dict["item_arr"]
		StationScene.StationType.BEACON:
			type_label.text = "哨站"
		StationScene.StationType.RUINS:
			type_label.text = "废墟"
		StationScene.StationType.CAVE:
			type_label.text = "洞穴"
			item_label.text = "还没有搜刮过这个洞穴"
	if distance == INF:
		cost_label.text = "无法到达"
	else:
		cost_label.text = "距离" + str(int(distance)) + "km"



	var tween: = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(0,400), 0.6).from(Vector2(-400,400))
