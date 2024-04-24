class_name BallSnapper
extends Area2D

@export var collision_shape: CollisionShape2D

var id: Vector2 = Vector2.ZERO
var captured_ball: bool = false
var capture_ball_colour: Enums.BALL_COLOUR

func _ready():
	SignalManager.ball_locked.connect(_on_ball_locked)

func _on_ball_locked(ball: Ball):
	var snapper_center: Vector2 = collision_shape.global_position
	var ball_center: Vector2 = ball.global_position
	var is_present_x: bool = (ball_center.x < (snapper_center.x + 29) and ball_center.x > (snapper_center.x - 29))
	var is_present_y: bool = (ball_center.y < (snapper_center.y + 29) and ball_center.y > (snapper_center.y - 29))
	
	if is_present_x and is_present_y:
		print("Found it: " + str(id))
		captured_ball = true
		capture_ball_colour = ball.colour
		ball.global_position = collision_shape.global_position
		SignalManager.ball_snapper_caught_ball.emit(self)
	
