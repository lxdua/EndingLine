extends Control
class_name TrainStatsScene

@export var train_stats_manager: TrainStatsManager

@export var money_label: Label
@export var load_label: Label
@export var gather_ability_label: Label
@export var power_label: Label
@export var solar_panel_efficiency_label: Label
@export var cost_efficiency_label: Label

func _process(delta: float) -> void:
	if visible == true:
		update_train_stats_scene()

func _on_close_button_pressed() -> void:
	visible = false

func update_train_stats_scene():
	money_label.text = "货币：" + str(train_stats_manager.current_money)
	load_label.text = "负重：" + str(train_stats_manager.current_train_load) + " / " + str(train_stats_manager.max_train_load)
	gather_ability_label.text = "采集力：" + str(train_stats_manager.gather_ability)
	power_label.text = "能源量：" + str(int(train_stats_manager.current_power)) + " / " + str(train_stats_manager.max_power)
	solar_panel_efficiency_label.text = "产能速度：" + str(train_stats_manager.solar_panel_efficiency)
	cost_efficiency_label.text = "耗能速度：" + str(train_stats_manager.cost_efficiency)
