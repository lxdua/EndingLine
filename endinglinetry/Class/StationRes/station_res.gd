extends Resource
class_name StationRes

enum StationType { RUINS, CITY, VILLAGE, GATHER_POINT, BEACON, CAVE }

@export var station_name: String
@export var station_type: StationType
@export var station_tax_rate: float
@export var station_supply_and_demand: Array[SupplyAndDemandRes]
