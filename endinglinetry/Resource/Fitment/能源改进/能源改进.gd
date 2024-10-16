extends Fitment

## 获得这个fitment时
func activate():
	var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")
	train_stats_manager.modifier_handler.get_modifier("SolarPanelEfficiencyModifier").add_new_value(
		ModifierValue.create_new_modifier_value(
			"能源改进", ModifierValue.Type.MULTIPLY, 0.1
		)
	)
	print("添加了遗物“能源改进”")

## 丢失这个fitment时
func deactivate():
	var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")
	train_stats_manager.modifier_handler.get_modifier("SolarPanelEfficiencyModifier").remove_value("能源改进")
	print("移除了遗物“能源改进”")
