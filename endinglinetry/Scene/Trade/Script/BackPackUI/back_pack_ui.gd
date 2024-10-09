extends PanelContainer
class_name BackPackUI

@onready var number_label: Label = %NumberLabel
@onready var max_number_label: Label = %MaxNumberLabel
@onready var sort_menu_button: SortMenuButton = %SortMenuButton
@onready var pack_item_list: VBoxContainer = %PackItemList
@onready var exit_button: Button = %ExitButton
@onready var progress_bar: ProgressBar = %ProgressBar

const GOODS_LIST_ITEM = preload("uid://colrqteefvben")


var trade_goods:TradeGoods


func update():
