@tool
extends PanelContainer
class_name GoodsListItem

@onready var icon_rect: TextureRect = $HBoxContainer/MarginContainer/IconRect
@onready var item_data_text: RichTextLabel = $HBoxContainer/ItemDataText

@export var icon:Texture2D=preload("res://icon.svg"):
	set(new_icon):
		icon=new_icon
		icon_rect.texture=icon
@export var goods_name:String="物品名称":
	set(new_name):
		goods_name=new_name
		set_item_data_text()
@export_range(1,99999) var goods_price:int=1:
	set(new_price):
		goods_price=new_price
		set_item_data_text()
@export_range(0,99) var price_multiplier:float=1:
	set(new_multiplier):
		price_multiplier=new_multiplier
		set_item_data_text()
@export_range(0,99999) var goods_number:int:
	set(new_number):
		goods_number=new_number
		set_item_data_text()


func set_item_data_text():
	item_data_text.text=goods_name+"\n当前单价:"+str(int(goods_price*price_multiplier))+"\n指导单价:"+str(goods_price)+"\n数量:"+str(goods_number)+"\n"
