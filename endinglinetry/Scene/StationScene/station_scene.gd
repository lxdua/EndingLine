extends Node3D
class_name StationScene

const BEACON = preload("res://Scene/StationScene/Building/Beacon/beacon.tscn")
const CAVE = preload("res://Scene/StationScene/Building/Cave/cave.tscn")
const CHARGING_PILE = preload("res://Scene/StationScene/Building/ChargingPile/charging_pile.tscn")
const FACTORY = preload("res://Scene/StationScene/Building/Factory/factory.tscn")
const GATHER_POINT = preload("res://Scene/StationScene/Building/GatherPoint/gather_point.tscn")
const RUINS = preload("res://Scene/StationScene/Building/Ruins/ruins.tscn")
const SHOP = preload("res://Scene/StationScene/Building/Shop/shop.tscn")

enum StationType { RUINS, CITY, VILLAGE, GATHER_POINT, BEACON, CAVE }

@export var station_name: String

@export var station_tip: String

@export var station_type: StationType

@export var station_dict: Dictionary

func _ready() -> void:
	update_station()

func update_station():
	match station_type:
		StationType.RUINS:
			pass
		StationType.CITY:
			var factory: Factory = FACTORY.instantiate()
			add_child(factory)
			var shop: Shop = SHOP.instantiate()
			shop.tax_rate = station_dict["tax_rate"]
			shop.demand_arr = station_dict["demand"].split(",")
			shop.demand_num = station_dict["demand_num"]
			shop.supply_arr = station_dict["supply"].split(",")
			shop.supply_num = station_dict["supply_num"]
			add_child(shop)
		StationType.VILLAGE:
			var shop: Shop = SHOP.instantiate()
			shop.tax_rate = station_dict["tax_rate"]
			shop.demand_arr = Array(station_dict["demand"].split(","))
			shop.demand_num = station_dict["demand_num"]
			shop.supply_arr = Array(station_dict["supply"].split(","))
			shop.supply_num = station_dict["supply_num"]
			add_child(shop)
		StationType.GATHER_POINT:
			var gather_point: GatherPoint = GATHER_POINT.instantiate()
			gather_point.item_arr = Array(station_dict["item"].split(","))
			gather_point.item_num_arr = Array(station_dict["item_num"].split(",")).filter(func(str_num): return str_num.to_int())
			add_child(gather_point)
		StationType.BEACON:
			var beacon: Beacon = BEACON.instantiate()
			#add_child(beacon)
		StationType.CAVE:
			var cave: Cave = CAVE.instantiate()
			cave.item_num = station_dict["item_num"]
			var pool: Array = station_dict["item_pool"].split(",")
			for it in pool:
				var item_name: String = it.split("*")[0]
				var num: int = int(it.split("*")[1])
				for i in range(num):
					cave.item_pool.append(item_name)
			add_child(cave)

func update_station_dict(type: StationScene.StationType, dict: Dictionary):
	station_type = type
	station_dict = dict
	station_name = station_dict["name"]
	station_tip = station_dict["tip"]
