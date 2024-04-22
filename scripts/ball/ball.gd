class_name Ball
extends RigidBody2D

static var num_balls_moving: int = 0
static var ball_id_incrementer: int = 1

@export var ball_collision_shape: CollisionShape2D
@export var ball_sprite: Sprite2D
@export var ball_material: Resource
@export var ball_colour: BallColour

var ball_id = 0
 
func _ready():
	ball_sprite.material = ball_material.duplicate()
	self.sleeping_state_changed.emit()
	ball_id = Ball.ball_id_incrementer
	Ball.ball_id_incrementer += 1
	#var colour: Plane = Plane(randf(),randf(),randf(),1.0)
	ball_sprite.material.set_shader_parameter("colour", ball_colour.get_colour())

func apply_force_on_ball(vector: Vector2):
	apply_central_impulse(vector)
	SignalManager.ball_shot.emit()
	
func lock_ball():
	self.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	self.linear_velocity = Vector2.ZERO
	self.sleeping = true
	set_deferred("lock_rotation", true) 
	set_deferred("freeze", true)
	self.sleeping_state_changed.emit()
	SignalManager.ball_locked.emit(self)

#func snap_ball(body):
	#var dist_top_right = (body.top_right.global_position - self.global_position) - Vector2.ZERO
	#var dist_right = (body.right.global_position - self.global_position) - Vector2.ZERO
	#var dist_bottom_right = (body.bottom_right.global_position - self.global_position) - Vector2.ZERO
	#var dist_bottom_left = (body.bottom_left.global_position - self.global_position) - Vector2.ZERO
	#var dist_left = (body.left.global_position - self.global_position) - Vector2.ZERO
	#var dist_top_left = (body.top_left.global_position - self.global_position) - Vector2.ZERO
	#
	#var tr = abs(dist_top_right.x) + abs(dist_top_right.y)
	#var r = abs(dist_right.x) + abs(dist_right.y)
	#var br = abs(dist_bottom_right.x) + abs(dist_bottom_right.y)
	#var bl = abs(dist_bottom_left.x) + abs(dist_bottom_left.y)
	#var l = abs(dist_left.x) + abs(dist_left.y)
	#var tl = abs(dist_top_left.x) + abs(dist_top_left.y)
	#
	#var distances: Array[float] = [tr,r,br,bl,l,tl]
	#var markers: Array[Marker2D] = [$TopRight2, $Right2, $BottomRight2, $BottomLeft2, $Left2, $TopLeft2]
	#
	#var min = 9999.9
	#var index = -1
	#for i in distances.size():
		#if distances[i] < min:
			#min = distances[i]
			#index = i
	#
	#self.global_position = markers[index].global_position
	#print(markers[index].global_position)

func _on_body_entered(body):
	if body.is_in_group("ceiling") or body.is_in_group("ball"):
		lock_ball()
	#if body.is_in_group("ball"):
		#snap_ball(body)

func _on_sleeping_state_changed():
	if self.sleeping:
		Ball.num_balls_moving -= 1
	else:
		num_balls_moving += 1
		
	if Ball.num_balls_moving == 0 and Enums.STATE.SHOOTING:
		SignalManager.balls_stopped.emit()
	print("Number of balls moving: " + str(Ball.num_balls_moving))
