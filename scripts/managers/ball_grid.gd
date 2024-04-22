extends Node

@export var ball_snapper: PackedScene

var screensize = Vector2.ZERO
var tile_size = Vector2(58,58)

func _ready():
	screensize = get_parent().get_viewport_rect().size
	build_ball_snapper_grid()

func _process(delta):
	pass

func build_ball_snapper_grid():
	var y_offset = 29
	var x_offset = 29
	for k in 15:
		for i in int(floor(screensize.x / tile_size.x)):
			var bs = ball_snapper.instantiate()
			add_child(bs)
			bs.global_position.y = k * tile_size.y + y_offset
			
			if k % 2 == 0:
				bs.global_position.x = i * tile_size.x + x_offset
			else:
				bs.global_position.x = i * tile_size.x
				
			bs.id = Vector2(i,k)
		y_offset -= 8
