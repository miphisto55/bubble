class_name BallGrid
extends Node

@export var ball_snapper_scene: PackedScene
@export var left_wall_collision_shape: CollisionShape2D

var screensize = Vector2.ZERO
var tile_size = Vector2(58,58)

var ball_snapper_dict: Dictionary

func _ready():
	screensize = get_parent().get_viewport_rect().size
	build_ball_snapper_grid()
	SignalManager.ball_snapper_grid_complete.emit()

func _process(_delta):
	pass

func build_ball_snapper_grid():
	var y_offset = 29
	var x_offset = 29
	var left_wall_pos = left_wall_collision_shape.global_position
	var grid_coloumns = 18
	var grid_rows = 18
	var wall_spacer = 7
	
	for k in grid_coloumns:
		for i in grid_rows:
			var bs = ball_snapper_scene.instantiate()
			add_child(bs)
			bs.global_position.y = k * tile_size.y + y_offset
			
			if k % 2 == 0:
				bs.global_position.x = (i * tile_size.x) + left_wall_pos.x + (tile_size.x * 2) + wall_spacer - x_offset
			else:
				bs.global_position.x = i * tile_size.x + left_wall_pos.x + (tile_size.x * 2) + wall_spacer
				
			bs.id = Vector2i(i,k)
			ball_snapper_dict[bs.id] = bs
		y_offset -= 8
