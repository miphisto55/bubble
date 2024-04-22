class_name BallGrid
extends Node

@export var ball_snapper_scene: PackedScene

var screensize = Vector2.ZERO
var tile_size = Vector2(58,58)

var ball_snapper_dict: Dictionary

func _ready():
	screensize = get_parent().get_viewport_rect().size
	build_ball_snapper_grid()

func _process(delta):
	pass

func build_ball_snapper_grid():
	var y_offset = 29
	var x_offset = 29
	for k in int(floor(screensize.x / tile_size.x)):
		for i in int(floor(screensize.x / tile_size.x)):
			var bs = ball_snapper_scene.instantiate()
			add_child(bs)
			bs.global_position.y = k * tile_size.y + y_offset
			
			if k % 2 == 0:
				bs.global_position.x = i * tile_size.x + x_offset
			else:
				bs.global_position.x = i * tile_size.x
				
			bs.id = Vector2i(i,k)
			ball_snapper_dict[bs.id] = bs
		y_offset -= 8
