extends PanelContainer
class_name PackItemDetails

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var number_label: Label = %NumberLabel
@onready var unit_price_label: Label = %UnitPriceLabel
@onready var total_price_label: Label = %TotalPriceLabel
@onready var unit_heavy_label: Label = %UnitHeavyLabel
@onready var total_heavy_label: Label = %TotalHeavyLabel
@onready var discard_button: Button = %DiscardButton

@onready var back_pack_ui: BackPackUI = get_tree().get_first_node_in_group("PackUI")
@onready var trade_manage:TradeManage = get_tree().get_first_node_in_group("TradeManage")

var trade_goods_struct:TradeGoodsStruct

func update():
	trade_goods_struct=back_pack_ui.selected_item
	if trade_goods_struct:
		name_label.text = trade_manage.get_goods_name(trade_goods_struct.id)
		description_label.text = trade_manage.get_goods_description(trade_goods_struct.id)
		number_label.text = "数量:"+str(trade_goods_struct.number)
		unit_price_label.text = "单价:" + str(trade_manage.get_goods_price(trade_goods_struct.id))
		total_price_label.text = "总价:" + str(trade_manage.get_goods_price(trade_goods_struct.id)*trade_goods_struct.number)
		unit_heavy_label.text = "单重:" + str(trade_manage.get_goods_heavy(trade_goods_struct.id))
		total_heavy_label.text = "总重:" + str(trade_manage.get_goods_heavy(trade_goods_struct.id)*trade_goods_struct.number)


func _on_discard_button_pressed() -> void:
	back_pack_ui.open_discard()
