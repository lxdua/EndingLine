extends Sprite2D
class_name Fog

@export var fog_width : int
@export var fog_height : int

var fog_image : Image
var fog_texture : ImageTexture

@export var light_texture : Texture2D
var light_image : Image

func _ready() -> void:
	fog_image = Image.create(fog_width,fog_height,false,Image.FORMAT_RGBA8)
	fog_image.fill(Color.WHITE)
	fog_texture = ImageTexture.create_from_image(fog_image)
	texture = fog_texture

	light_image=light_texture.get_image()

func _physics_process(delta: float) -> void:
	add_light_point(get_global_mouse_position(),64)

func add_light_point(point_position:Vector2,point_size:int=16):
	print("position",position,"  point_position",point_position)
	#point_position=Vector2i(to_local(point_position)+position)-light_image.get_used_rect().size/2
	point_position+=Vector2(fog_width,fog_height)/2-Vector2(light_image.get_size()/2)-position
	print(point_position)
	fog_image.blend_rect(light_image,Rect2i(Vector2.ZERO,light_image.get_size()),point_position)
	fog_texture.update(fog_image)
