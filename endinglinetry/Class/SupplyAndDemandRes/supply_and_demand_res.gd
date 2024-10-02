extends Resource
class_name SupplyAndDemandRes

enum SupplyAndDemandType { SUPPLY, DEMAND }

@export var type: SupplyAndDemandType
@export var item: ItemRes
@export var amount: int
