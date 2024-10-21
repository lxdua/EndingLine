extends Node
class_name TrainStatsManager

@export var modifier_handler: ModifierHandler
@export var fitment_handler: FitmentHandler
@export var buff_handler: BuffHandler
@export var base_scene: BaseScene

var is_driving: bool = false

func _ready() -> void:
	current_speed = 3.0
	current_train_load = 10.0

func _physics_process(delta: float) -> void:
	get_solar_power(delta)
	cost_power(delta)

func get_final_value(modifier_name: String, base: float) -> float:
	return modifier_handler.get_modifier_result(modifier_name, base)

#region 资源部分

var current_money: int = 2000

func has_money(need: int):
	return need <= current_money

func cost_money(need: int):
	current_money -= need

#endregion

#region 载重部分

@export var train_load_label: Label

var max_train_load: float = 1000.0:
	set(v):
		max_train_load = clamp(v, 0, INF)
		update_train_load_label()
	get:
		return get_final_value("MaxLoadModifier", max_train_load)

var current_train_load: float:
	set(v):
		current_train_load = clamp(v, 0, max_train_load)
		update_train_load_label()
		var percentage: float = current_train_load / max_train_load
		if percentage >= 0.7:
			modifier_handler.get_modifier("CurrentSpeedModifier").get_value("OverloadModifierValue").value = -0.3
		elif percentage >= 0.3:
			modifier_handler.get_modifier("CurrentSpeedModifier").get_value("OverloadModifierValue").value = 0.0
		else:
			modifier_handler.get_modifier("CurrentSpeedModifier").get_value("OverloadModifierValue").value = 0.1
	get:
		return get_final_value("CurrentLoadModifier", current_train_load)

func has_load(need: int):
	return need <= max_train_load - current_train_load

func update_train_load_label():
	train_load_label.text = "载重： " + str(current_train_load) + " / " + str(max_train_load)

func _on_current_load_modifier_value_changed() -> void:
	update_train_load_label()

func _on_max_load_modifier_value_changed() -> void:
	update_train_load_label()

#endregion

#region 速度部分

@export var train_speed_label: Label

var current_speed: float = 1.0:
	set(v):
		current_speed = clamp(v, 0, INF)
		update_train_speed_label()
	get:
		return get_final_value("CurrentSpeedModifier", current_speed)

var total_journey: float = 0.0

func update_train_speed_label():
	train_speed_label.text = "速度：" + str(current_speed)

func _on_current_speed_modifier_value_changed() -> void:
	update_train_speed_label()


#endregion

#region 能源部分

@export var power_progress_bar: TextureProgressBar

var max_power: float = 50.0:
	set(v):
		max_power = clampf(v, 0.0, INF)
		update_power_progress_bar()
	get:
		return get_final_value("MaxPowerModifier", max_power)

var current_power: float = 25.0:
	set(v):
		current_power = clampf(v, 0.0, max_power)
		update_power_progress_bar()
	get:
		return get_final_value("CurrentPowerModifier", current_power)

var cost_efficiency: int = 2:
	set(v):
		cost_efficiency = clamp(v, 0.0, INF)
	get:
		return get_final_value("CostEfficiencyModifier", cost_efficiency)

func cost_power(delta: float):
	if not is_driving:
		return
	current_power -= cost_efficiency * delta

func update_power_progress_bar():
	power_progress_bar.value = current_power / max_power

func _on_current_power_modifier_value_changed() -> void:
	update_power_progress_bar()

func _on_max_power_modifier_value_changed() -> void:
	update_power_progress_bar()

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

#region 采集力部分

var gather_ability: float

#endregion
