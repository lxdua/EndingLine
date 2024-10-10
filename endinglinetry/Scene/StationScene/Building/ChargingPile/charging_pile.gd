extends Building
class_name ChargingPile

@onready var charging_pile_ui: CanvasLayer = $ChargingPileUI
@onready var electric_label: Label = $ChargingPileUI/PanelContainer/MarginContainer/VBoxContainer/ElectricLabel
@onready var price_label: Label = $ChargingPileUI/PanelContainer/MarginContainer/VBoxContainer/PriceLabel
@onready var yes_button: TextureButton = $ChargingPileUI/PanelContainer/MarginContainer/VBoxContainer/AskContainer/YesButton

@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")

@export var cost: int

func press_building():
	print("ChargingPile!")
	yes_button.disabled = not train_stats_manager.has_money(cost)
	charging_pile_ui.show()

func _ready() -> void:
	charging_pile_ui.hide()
	price_label.text = "充电花费：" + str(cost)

func _on_no_button_pressed() -> void:
	charging_pile_ui.hide()

func _on_yes_button_pressed() -> void:
	train_stats_manager.cost_money(cost)
	train_stats_manager.current_power = train_stats_manager.max_power
