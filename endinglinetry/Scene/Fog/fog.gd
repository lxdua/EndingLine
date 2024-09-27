extends Sprite2D
class_name Fog

@export var fog_width : int
@export var fog_height : int

var fog_image : Image
var fog_texture : ImageTexture

@export var light_texture : Texture2D
var light_image : Image


var light_points:Array[Dictionary]
func _ready() -> void:
	fog_image = Image.create(fog_width,fog_height,false,Image.FORMAT_RGBA8)
	fog_image.fill(Color.WHITE)
	fog_texture = ImageTexture.create_from_image(fog_image)
	texture = fog_texture

	light_image=light_texture.get_image()


func add_light_point(point_position:Vector2,point_size:int=64):
	if light_points.any(func(p):return point_position.distance_to(p["position"])<=10 and point_position<p["size"]):
		return
	var light_point :={"position":point_position,"size":point_size}
	light_points.append(light_point)
	light_image.resize(point_size,point_size)
	point_position+=Vector2(fog_width,fog_height)/2-Vector2(light_image.get_size()/2)-position
	fog_image.blend_rect(light_image,Rect2i(Vector2.ZERO,light_image.get_size()),point_position)
	fog_texture.update(fog_image)

func is_in_light(pos:Vector2)->bool:
	if light_points.any(func(p):return pos.distance_to(p["position"])<=p["size"]/2):
		return true
	else:
		return false
