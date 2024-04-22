extends Node2D

@export var turret: Marker2D
@export var shoot_origin: Marker2D
@export var shoot_direction_marker: Marker2D
@export var ball: PackedScene
@export var create_ball_timer: Timer

@export var rotation_speed: float
@export var shot_power: int = 700

var current_ball: Ball

func _ready():
	current_ball = create_ball(shoot_origin.global_position)

func _process(delta):
	get_input(delta)
	
func get_input(delta):
	if Input.is_action_pressed("rotate_left") and (StateManager.current_state == Enums.STATE.AIMING):
		turret.rotate(-1.0 * delta * rotation_speed)
	if Input.is_action_pressed("rotate_right") and (StateManager.current_state == Enums.STATE.AIMING):
		turret.rotate(1.0 * delta * rotation_speed)
	if Input.is_action_just_pressed("shoot") and (StateManager.current_state == Enums.STATE.AIMING):
		if current_ball:
			var shot_direction: Vector2 = shoot_direction_marker.global_position - shoot_origin.global_position
			current_ball.apply_force_on_ball(shot_direction.normalized() * shot_power)
			create_ball_timer.start()
		
	turret.rotation_degrees = clamp(turret.rotation_degrees, -88, 88)

func create_ball(pos: Vector2) -> Ball:
	var b: RigidBody2D = ball.instantiate()
	add_child(b)
	b.global_position = pos
	b.set_colour(randi_range(0, Enums.BALL_COLOUR.size()-8))
	return b

func _on_create_ball_timer_timeout():
	current_ball = create_ball(shoot_origin.global_position)
