extends Node2D

@export var turret: Marker2D
@export var shoot_origin: Marker2D
@export var shoot_direction_marker: Marker2D
@export var ball: PackedScene

@export var rotation_speed: float
@export var shot_power: int = 700

func _ready():
	pass 

func _process(delta):
	get_input(delta)
	
func get_input(delta):
	if Input.is_action_pressed("rotate_left") and (StateManager.current_state == Enums.STATE.AIMING):
		turret.rotate(-1.0 * delta * rotation_speed)
	if Input.is_action_pressed("rotate_right") and (StateManager.current_state == Enums.STATE.AIMING):
		turret.rotate(1.0 * delta * rotation_speed)
	if Input.is_action_just_pressed("shoot") and (StateManager.current_state == Enums.STATE.AIMING):
		var b: RigidBody2D = ball.instantiate()
		add_child(b)
		b.global_position = shoot_origin.global_position
		var shot_direction: Vector2 = shoot_direction_marker.global_position - shoot_origin.global_position
		b.apply_force_on_ball(shot_direction.normalized() * shot_power)
		SignalManager.ball_shot.emit()
		
	turret.rotation_degrees = clamp(turret.rotation_degrees, -88, 88)
