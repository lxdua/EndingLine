extends Resource
class_name MapRes

## 站点的视觉位置
@export var station_pos_list: Array[Vector2]

## 三个参数分别是 起点编号 终点编号 路程
@export var track_list: Array[Array]

## 四个参数分别是 起点编号 终点编号 路程 建造花费
@export var buildable_track_list: Array[Array]
