extends Node
class_name TrainStatsManager

@export var modifier_handler: ModifierHandler

func get_final_value(modifier_name: String, base: int) -> int:
	return modifier_handler.get_modifier_value(modifier_name, base)

#region 资源部分

var current_money: int = 0

func has_money(need: int):
	return need <= current_money

#endregion

#region 载重部分

var max_train_load: int:
	set(v):
		max_train_load = clamp(v, 0, INF)
	get:
		return get_final_value("MaxLoadModifier", max_train_load)

var current_train_load: int:
	set(v):
		current_train_load = clamp(v, 0, max_train_load)
	get:
		return get_final_value("CurrentSpeedModifier", current_train_load)

func has_load(need: int):
	return need <= max_train_load - current_train_load

#endregion

#region 速度部分

var max_speed: int:
	set(v):
		max_speed = clamp(v, 0, INF)
	get:
		return get_final_value("MaxSpeedModifier", max_speed)

var current_speed: int:
	set(v):
		current_speed = clamp(v, 0, max_speed)
	get:
		return get_final_value("CurrentSpeedModifier", current_speed)

#endregion

#region 能源部分

var max_power: int:
	set(v):
		max_power = clamp(v, 0, INF)
	get:
		return get_final_value("MaxPowerModifier", max_power)

var current_power: int:
	set(v):
		current_power = clamp(v, 0, max_power)
	get:
		return get_final_value("CurrentPowerModifier", current_power)

#endregion

#region 太阳能部分

var solar_panel_efficiency: int:
	set(v):
		solar_panel_efficiency = v
	get:
		return get_final_value("SolarPanelEfficiencyModifier", solar_panel_efficiency)

func get_solar_power():
	pass

#endregion
