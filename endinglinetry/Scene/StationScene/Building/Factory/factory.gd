extends Building
class_name Factory

const FACTORY_FITMENT_UI = preload("res://Scene/StationScene/Building/Factory/factory_fitment_ui.tscn")

@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")
@onready var fitment_handler: FitmentHandler = get_tree().get_first_node_in_group("FitmentHandler")

@export var card_layer: ColorRect
@export var factory_ui: CanvasLayer
@export var buy_button: Button
@export var price_label: Label

@export var cost: int

@onready var facory_ui_root: Control = $FactoryUI/FacoryUIRoot

@onready var aki_ui: FactoryFitmentUI = $FactoryUI/FacoryUIRoot/CardLayer/AkiUI
@onready var ruu_ui: FactoryFitmentUI = $FactoryUI/FacoryUIRoot/CardLayer/RuuUI
@onready var train_ui: FactoryFitmentUI = $FactoryUI/FacoryUIRoot/CardLayer/TrainUI


func press_building():
	print("Factory!")
	buy_button.disabled = not train_stats_manager.has_money(cost)
	factory_ui.show()

func _ready() -> void:
	factory_ui.hide()
	aki_ui.factory_fitment_button_pressed.connect(_on_factory_fitment_button_pressed)
	ruu_ui.factory_fitment_button_pressed.connect(_on_factory_fitment_button_pressed)
	train_ui.factory_fitment_button_pressed.connect(_on_factory_fitment_button_pressed)
	aki_ui.hide()
	ruu_ui.hide()
	train_ui.hide()
	price_label.text = "价格：" + str(cost)

func _on_close_button_pressed() -> void:
	factory_ui.hide()

func _on_buy_button_pressed() -> void:
	train_stats_manager.cost_money(cost)
	update_fitment_container()

func _on_factory_fitment_button_pressed(fitment_name: String):
	fitment_handler.add_fitment_by_name(fitment_name)
	await play_take_away_animation(fitment_handler.get_fitment_by_name(fitment_name).holder)
	play_push_in_animation()

func can_add(fitment: Fitment) -> bool:
	if fitment_handler.has_fitment_by_name(fitment.fitment_name):
		return false
	for pre_fitment_name: String in fitment.pre_fitment_name_list:
		if not fitment_handler.has_fitment_by_name(pre_fitment_name):
			return false
	return true

func update_fitment_container():

	var train_fitment: Array
	var aki_fitment: Array
	var ruu_fitment: Array

	for fitment_name in fitment_handler.fitment_dict:
		var fitment: Fitment = fitment_handler.fitment_dict[fitment_name].instantiate()
		if not can_add(fitment):
			continue
		match fitment.holder:
			Fitment.Holder.AKI:
				aki_fitment.append(fitment)
			Fitment.Holder.RUU:
				ruu_fitment.append(fitment)
			Fitment.Holder.TRAIN:
				train_fitment.append(fitment)
	if not aki_fitment.is_empty():
		aki_ui.update_fitment(aki_fitment.pick_random())
	if not ruu_fitment.is_empty():
		ruu_ui.update_fitment(ruu_fitment.pick_random())
	if not train_fitment.is_empty():
		train_ui.update_fitment(train_fitment.pick_random())

	play_pop_out_animation()

func play_take_away_animation(holder: Fitment.Holder):
	var take_away_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	var card: FactoryFitmentUI
	match holder:
		Fitment.Holder.AKI:
			card = aki_ui
		Fitment.Holder.RUU:
			card = ruu_ui
		Fitment.Holder.TRAIN:
			card = train_ui
	take_away_tween.tween_property(card, "position", Vector2(card.position.x, -672), 0.6)
	await take_away_tween.finished
	card.hide()

func play_push_in_animation():
	var aki_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var ruu_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var train_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	aki_ui.position = Vector2(640-448,80)
	ruu_ui.position = Vector2(912+448,80)
	train_ui.position = Vector2(768,80)

	aki_ui.disabled = true
	ruu_ui.disabled = true
	train_ui.disabled = true

	aki_tween.tween_property(aki_ui, "position", Vector2(640,80), 0.3).from(Vector2(640-448,80))
	ruu_tween.tween_property(ruu_ui, "position", Vector2(912,80), 0.3).from(Vector2(912+448,80))
	train_tween.tween_property(train_ui, "position", Vector2(768,80), 0.3).from(Vector2(768,80))

	aki_tween.tween_property(aki_ui, "position", Vector2(640,832), 0.3).from(Vector2(640,80))
	ruu_tween.tween_property(ruu_ui, "position", Vector2(912,832), 0.3).from(Vector2(912,80))
	train_tween.tween_property(train_ui, "position", Vector2(768,832), 0.3).from(Vector2(768,80))

	await get_tree().create_timer(0.7).timeout

	aki_ui.hide()
	ruu_ui.hide()
	train_ui.hide()

func play_pop_out_animation():
	var shake_tween: = create_tween()
	for i in range(15):
		var offset: Vector2 = Vector2(randf_range(-4, 4), randf_range(-4, 4))
		shake_tween.tween_property(facory_ui_root, "position", offset, 1.0/15.0)
	shake_tween.tween_property(facory_ui_root, "position", Vector2.ZERO, 1.0/15.0)
	await shake_tween.finished

	var aki_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var ruu_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var train_tween: = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	aki_ui.position = Vector2(640,832)
	ruu_ui.position = Vector2(912,832)
	train_ui.position = Vector2(768,832)

	aki_ui.disabled = true
	ruu_ui.disabled = true
	train_ui.disabled = true

	if aki_ui.fitment != null:
		aki_ui.show()
	if ruu_ui.fitment != null:
		ruu_ui.show()
	if train_ui.fitment != null:
		train_ui.show()

	aki_tween.tween_property(aki_ui, "position", Vector2(640,80), 0.3).from(Vector2(640,832))
	ruu_tween.tween_property(ruu_ui, "position", Vector2(912,80), 0.3).from(Vector2(912,832))
	train_tween.tween_property(train_ui, "position", Vector2(768,80), 0.3).from(Vector2(768,832))

	aki_tween.tween_property(aki_ui, "position", Vector2(640-448,80), 0.3).from(Vector2(640,80))
	ruu_tween.tween_property(ruu_ui, "position", Vector2(912+448,80), 0.3).from(Vector2(912,80))
	train_tween.tween_property(train_ui, "position", Vector2(768,80), 0.3).from(Vector2(768,80))

	await get_tree().create_timer(0.7).timeout
	aki_ui.disabled = false
	ruu_ui.disabled = false
	train_ui.disabled = false
