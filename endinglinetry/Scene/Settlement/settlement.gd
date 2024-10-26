extends CanvasLayer

@export_file("*.tscn") var prison_scene: String

@export var fitment_container: HFlowContainer
@export var money_label: Label
@export var time_label: Label
@export var total_journey_label: Label

@onready var base_scene: BaseScene = get_tree().get_first_node_in_group("BaseScene")
@onready var train_stats_manager: TrainStatsManager = get_tree().get_first_node_in_group("TrainStatsManager")

func back_to_prison():
	CurtainLayer.curtain_change_scene(prison_scene, "少女祈祷中。。。")

func _on_button_pressed() -> void:
	back_to_prison()

func show_settlement():
	money_label.text = "赚取货币数："
	time_label.text = "游戏时间：" + str(int(base_scene.current_time - base_scene.start_time)) + "分钟"
	total_journey_label.text = "总路程：" + str(int(base_scene.train_stats_manager.total_journey)) + "km"
	for icon in fitment_container.get_children():
		icon.free()
	for fitment: Fitment in train_stats_manager.fitment_handler.get_children():
		var texr: = TextureRect.new()
		texr.texture = fitment.icon
		fitment_container.add_child(texr)
	show()
