extends Control
class_name TrainStatsScene

const BUFF_UI = preload("res://Scene/Other/BuffUI/buff_ui.tscn")

@export var base_scene: BaseScene
@export var train_stats_manager: TrainStatsManager

@export var money_label: Label
@export var load_label: Label
@export var gather_ability_label: Label

@export var speed_label: Label
@export var power_label: Label
@export var solar_panel_efficiency_label: Label
@export var cost_efficiency_label: Label

@export var buff_flow_container: HFlowContainer

func _process(delta: float) -> void:
	if visible == true:
		update_train_stats()

func _on_close_button_pressed() -> void:
	visible = false
	base_scene.hide_all_secondary_scene()

func update_train_stats():
	money_label.text = "货币： " + str(train_stats_manager.current_money)
	load_label.text = "负重： " + str(train_stats_manager.current_train_load) + " / " + str(train_stats_manager.max_train_load)
	gather_ability_label.text = "采集力： " + str(train_stats_manager.gather_ability)
	speed_label.text = "速度： " + str(train_stats_manager.current_speed)
	power_label.text = "能源量： " + str(int(train_stats_manager.current_power)) + " / " + str(train_stats_manager.max_power)
	solar_panel_efficiency_label.text = "产能速度： " + str(train_stats_manager.solar_panel_efficiency)
	cost_efficiency_label.text = "耗能速度： " + str(train_stats_manager.cost_efficiency)

func update_buff_ui():
	for buff_ui in buff_flow_container.get_children():
		buff_ui.free()
	for buff in train_stats_manager.buff_handler.get_children():
		var new_buff_ui: = BUFF_UI.instantiate()
		new_buff_ui.update_ui(buff)
		buff_flow_container.add_child(new_buff_ui)
