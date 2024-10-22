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

var station_name: String
var station_type: StationType
var station_description: String

var station_dict: Dictionary

func update_station_by_dict(type: StationScene.StationType, dict: Dictionary):
	station_type = type
	station_dict = dict.duplicate()
	print("sta:", station_dict)
	match station_type:
		StationType.RUINS:
			station_name = station_dict["ruins_name"]
		StationType.CITY:
			station_name = station_dict["city_name"]
			var factory: Factory = FACTORY.instantiate()
			add_child(factory)
			var shop: Shop = SHOP.instantiate()
			shop.tax_rate = station_dict["tax_rate"]
			shop.demand_arr = station_dict["demand"].split(",")
			shop.demand_num = station_dict["demand_num"]
			shop.supply_arr = station_dict["supply"].split(",")
			shop.supply_num = station_dict["supply_num"]
			prints("sta:", shop.tax_rate, shop.demand_arr, shop.supply_arr)
			add_child(shop)
		StationType.VILLAGE:
			station_name = station_dict["village_name"]
			var shop: Shop = SHOP.instantiate()
			shop.tax_rate = station_dict["tax_rate"]
			shop.demand_arr = station_dict["demand"].split(",")
			shop.demand_num = station_dict["demand_num"]
			shop.supply_arr = station_dict["supply"].split(",")
			shop.supply_num = station_dict["supply_num"]
			add_child(shop)
		StationType.GATHER_POINT:
			pass
		StationType.BEACON:
			pass
		StationType.CAVE:
			pass
