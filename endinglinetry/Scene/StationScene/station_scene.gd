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

func update_station_by_dict(type: StationType, dict: Dictionary):
	station_type = type
	match type:
		StationType.RUINS:
			pass
		StationType.CITY:
			station_name = dict["city_name"]
			var factory: Factory = FACTORY.instantiate()
			add_child(factory)
			var shop: Shop = SHOP.instantiate()
			shop.tax_rate = dict["tax_rate"]
			"666".split()
			shop.demand_arr = dict["demand"].split("，")
			shop.demand_num = dict["demand_num"]
			#shop.supply_and_demand_arr = dict["supply_and_demand"].split("，")
			#shop.supply_and_demand_num = dict["supply_and_demand_num"]
			shop.supply_arr = dict["supply"].split("，")
			shop.supply_num = dict["supply_num"]
			add_child(shop)
		StationType.VILLAGE:
			station_name = dict["village_name"]
			var shop: Shop = SHOP.instantiate()
			shop.tax_rate = dict["tax_rate"]
			shop.demand_arr = dict["demand"].split("，")
			shop.demand_num = dict["demand_num"]
			#shop.supply_and_demand_arr = dict["supply_and_demand"].split("，")
			#shop.supply_and_demand_num = dict["supply_and_demand_num"]
			shop.supply_arr = dict["supply"].split("，")
			shop.supply_num = dict["supply_num"]
			add_child(shop)
		StationType.GATHER_POINT:
			pass
		StationType.BEACON:
			pass
		StationType.CAVE:
			pass
