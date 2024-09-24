@tool
extends PanelContainer
class_name GoodsListItem

@onready var icon_rect: TextureRect = $HBoxContainer/MarginContainer/IconRect
@onready var item_data_text: Label = $HBoxContainer/ItemDataText
@onready var trade_manage: TradeManage = $"../../../../../../../../.."
@onready var trade_ui: TradeUI = $"../../../../../../../.."




@export var icon:Texture2D=preload("res://icon.svg"):
	set(new_icon):
		icon=new_icon
		icon_rect.texture=icon
@export var goods_name:String="物品名称":
	set(new_name):
		goods_name=new_name
		update_item_data_text()
@export_range(1,99999) var goods_price:int=1:
	set(new_price):
		goods_price=new_price
		update_item_data_text()
@export_range(0,99) var price_multiplier:float=1:
	set(new_multiplier):
		price_multiplier=new_multiplier
		update_item_data_text()
@export_range(0,99999) var goods_number:int:
	set(new_number):
		goods_number=new_number
		update_item_data_text()


func update_item_data_text():
	item_data_text.text=goods_name+"\n当前单价:"+str(int(goods_price*price_multiplier))+"\n指导单价:"+str(goods_price)+"\n数量:"+str(goods_number)+"\n"


var goods_struct:TradeGoodsStruct:
	set(new_g):
		goods_struct=new_g
		update()


func update():
	if goods_struct:
		goods_name=trade_manage.get_goods_name(goods_struct.id)
		goods_price=trade_manage.get_goods_price(goods_struct.id)
		price_multiplier=goods_struct.price_multiplier
		goods_number=goods_struct.number

func _ready() -> void:
	item_data_text.add_theme_font_size_override("font_size",custom_minimum_size.y/4)

func _on_reference_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.pressed:
				trade_ui.show_goods_details(goods_struct)
