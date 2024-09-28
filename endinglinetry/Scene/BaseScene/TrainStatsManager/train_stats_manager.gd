extends Node
class_name TrainStatsManager

@export var modifier_handler: ModifierHandler
@export var base_scene: BaseScene

func _physics_process(delta: float) -> void:
	get_solar_power(delta)
	cost_power(delta)

func get_final_value(modifier_name: String, base: float) -> float:
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

@onready var power_progress_bar: TextureProgressBar = $"../UI/StatusBarContainer/HBoxContainer/PowerProgressBar"

var max_power: float = 50.0:
	set(v):
		max_power = clampf(v, 0.0, INF)
	get:
		return get_final_value("MaxPowerModifier", max_power)

var current_power: float = 25.0:
	set(v):
		current_power = clampf(v, 0.0, max_power)
		power_progress_bar.value = current_power / max_power
	get:
		return get_final_value("CurrentPowerModifier", current_power)

var cost_efficiency: int = 2:
	set(v):
		cost_efficiency = clamp(v, 0.0, INF)
	get:
		return get_final_value("CostEfficiencyModifier", cost_efficiency)

func cost_power(delta: float):
	current_power -= cost_efficiency * delta

#endregion

#region 太阳能部分

var solar_panel_efficiency: int = 3:
	set(v):
		solar_panel_efficiency = v
	get:
		return get_final_value("SolarPanelEfficiencyModifier", solar_panel_efficiency)

func get_solar_power(delta: float):
	if not base_scene.is_daytime():
		return
	current_power += solar_panel_efficiency * delta

#endregion
