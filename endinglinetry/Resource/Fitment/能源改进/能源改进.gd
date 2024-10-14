extends Fitment

@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")
@onready var solar_panel_efficiency_modifier: Modifier = train_stats_manager.modifier_handler.get_modifier("SolarPanelEfficiencyModifier")

## 获得这个fitment时
func activate():
	solar_panel_efficiency_modifier.add_new_value(
		ModifierValue.create_new_modifier_value(
			"能源改进", ModifierValue.Type.MULTIPLY, 0.1
		)
	)
	print("添加了遗物“能源改进”")

## 丢失这个fitment时
func deactivate():
	solar_panel_efficiency_modifier.remove_value("能源改进")
	print("移除了遗物“能源改进”")
