extends Building
class_name Factory

const FACTORY_FITMENT_UI = preload("res://Scene/StationScene/Building/Factory/factory_fitment_ui.tscn")

@onready var factory_ui: CanvasLayer = $FactoryUI
@onready var buy_button: Button = $FactoryUI/PanelContainer/MarginContainer/VBoxContainer/BuyButton
@onready var fitment_container: HBoxContainer = $FactoryUI/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/FitmentContainer
@onready var price_label: Label = $FactoryUI/PanelContainer/MarginContainer/VBoxContainer/PriceLabel
@onready var covering_layer: ColorRect = $FactoryUI/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/CoveringLayer

@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")

@export var cost: int

func press_building():
	print("Factory!")
	buy_button.disabled = not train_stats_manager.has_money(cost)
	factory_ui.show()

func _ready() -> void:
	covering_layer.hide()
	factory_ui.hide()
	price_label.text = "价格：" + str(cost)

func _on_close_button_pressed() -> void:
	factory_ui.hide()

func _on_buy_button_pressed() -> void:
	train_stats_manager.cost_money(cost)
	covering_layer.hide()
	update_fitment_container()

func _on_factory_fitment_button_pressed(fitment_name: String):
	train_stats_manager.fitment_handler.add_fitment_by_name(fitment_name)
	covering_layer.show()

func update_fitment_container():
	var fitment_handler: FitmentHandler = get_tree().get_first_node_in_group("TrainStatsManager").fitment_handler

	for factory_fitment_ui in fitment_container.get_children():
		factory_fitment_ui.free()
	var train_fitment: Array
	var aki_fitment: Array
	var ruu_fitment: Array
	for fitment_name in FitmentHandler.FITMENT_DICT:
		var fitment: Fitment = FitmentHandler.FITMENT_DICT[fitment_name].instantiate()
		if fitment_handler.has_fitment_by_name(fitment.fitment_name):
			continue;
		elif fitment.holder == Fitment.Holder.AKI:
			aki_fitment.append(fitment)
		elif fitment.holder == Fitment.Holder.RUU:
			ruu_fitment.append(fitment)
		else:
			train_fitment.append(fitment)
	if not aki_fitment.is_empty():
		add_new_fitment_ui(aki_fitment.pick_random())
	if not ruu_fitment.is_empty():
		add_new_fitment_ui(ruu_fitment.pick_random())
	if not train_fitment.is_empty():
		add_new_fitment_ui(train_fitment.pick_random())

func add_new_fitment_ui(fitment: Fitment):
	var factory_fitment_ui: = FACTORY_FITMENT_UI.instantiate()
	factory_fitment_ui.fitment = fitment
	factory_fitment_ui.factory_fitment_button_pressed.connect(_on_factory_fitment_button_pressed)
	fitment_container.add_child(factory_fitment_ui)
