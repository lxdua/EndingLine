extends Resource
class_name SupplyAndDemandRes

enum SupplyAndDemandType { SUPPLY, DEMAND }

## 类别 是供还是需
@export var type: SupplyAndDemandType
## 物品信息
@export var item: ItemRes
## 数量
@export var amount: int
