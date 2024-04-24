class_name BallSnapper
extends Area2D

@export var collision_shape: CollisionShape2D

var id: Vector2i = Vector2.ZERO
var captured_ball: Ball = null
var capture_ball_colour: Enums.BALL_COLOUR = -1

func _ready():
	SignalManager.ball_locked.connect(_on_ball_locked)
	SignalManager.clear_matching_balls.connect(_on_clear_matching_balls)

func _on_clear_matching_balls(visited_nodes: Array[Vector2i]):
	if visited_nodes.has(id):
		captured_ball.queue_free()
		capture_ball_colour = -1

func _on_ball_locked(ball: Ball):
	var snapper_center: Vector2 = collision_shape.global_position
	var ball_center: Vector2 = ball.global_position
	var is_present_x: bool = (ball_center.x < (snapper_center.x + 29) and ball_center.x > (snapper_center.x - 29))
	var is_present_y: bool = (ball_center.y < (snapper_center.y + 29) and ball_center.y > (snapper_center.y - 29))
	
	if is_present_x and is_present_y:
		ball.global_position = collision_shape.global_position
		captured_ball = ball
		capture_ball_colour = ball.colour
		SignalManager.ball_snapper_caught_ball.emit(self)
	
