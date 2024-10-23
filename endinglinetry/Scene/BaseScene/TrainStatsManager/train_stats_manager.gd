extends Node
class_name TrainStatsManager

@export var modifier_handler: ModifierHandler
@export var fitment_handler: FitmentHandler
@export var buff_handler: BuffHandler
@export var base_scene: BaseScene

var is_driving: bool = false

func _ready() -> void:
	current_speed = 6.0
	max_train_load = 1000.0
	current_train_load = 10.0
	current_money = 50000

func _physics_process(delta: float) -> void:
	get_solar_power(delta)
	cost_power(delta)

#region 资源部分

signal money_update

var current_money: int:
	set(v):
		current_money = v
		money_update.emit()

func has_money(need: int):
	return need <= current_money

func cost_money(need: int):
	current_money -= need

#endregion

#region 载重部分

signal load_update

var max_train_load: float:
	set(v):
		max_train_load = clamp(v, 0, INF)
		load_update.emit()
	get:
		return modifier_handler.get_modifier_result_intelligently("max_train_load", max_train_load, load_update)

var current_train_load: float:
	set(v):
		current_train_load = clamp(v, 0, max_train_load)
		load_update.emit()
		# TODO 记得变成buff
		#var percentage: float = current_train_load / max_train_load
		#if percentage >= 0.7:
			#modifier_handler.get_modifier("CurrentSpeedModifier").get_value("OverloadModifierValue").value = -0.3
		#elif percentage >= 0.3:
			#modifier_handler.get_modifier("CurrentSpeedModifier").get_value("OverloadModifierValue").value = 0.0
		#else:
			#modifier_handler.get_modifier("CurrentSpeedModifier").get_value("OverloadModifierValue").value = 0.1
	get:
		return modifier_handler.get_modifier_result_intelligently("current_train_load", current_train_load, load_update)

func has_load(need: int):
	return need <= max_train_load - current_train_load

#endregion

#region 速度部分

signal speed_update

var current_speed: float:
	set(v):
		current_speed = clamp(v, 0, INF)
		speed_update.emit()
	get:
		return modifier_handler.get_modifier_result_intelligently("current_speed", current_speed, speed_update)

var total_journey: float = 0.0

#endregion

#region 能源部分

signal power_update

var max_power: float = 50.0:
	set(v):
		max_power = clampf(v, 0.0, INF)
		power_update.emit()
	get:
		return modifier_handler.get_modifier_result_intelligently("max_power", max_power, power_update)

var current_power: float = 25.0:
	set(v):
		current_power = clampf(v, 0.0, max_power)
		power_update.emit()
	get:
		return modifier_handler.get_modifier_result_intelligently("current_power", current_power, power_update)

var cost_efficiency: int = 2:
	set(v):
		cost_efficiency = clamp(v, 0.0, INF)
	get:
		return modifier_handler.get_modifier_result_intelligently("cost_efficiency", cost_efficiency)

func cost_power(delta: float):
	if not is_driving:
		return
	current_power -= cost_efficiency * delta

#endregion

#region 太阳能部分

var solar_panel_efficiency: int = 3:
	set(v):
		solar_panel_efficiency = v

func get_solar_power(delta: float):
	if not base_scene.is_daytime():
		return
	current_power += solar_panel_efficiency * delta

#endregion

#region 采集力部分

var gather_ability: int:
	set(v):
		gather_ability = v
	get:
		return modifier_handler.get_modifier_result_intelligently("gather_ability", gather_ability)

func get_gather_output(base_output: int) -> int:
	return roundf(base_output * float(100 + gather_ability * 15) / 100.0)

#endregion
