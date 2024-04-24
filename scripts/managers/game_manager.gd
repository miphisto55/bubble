class_name GameManager
extends Node

@export var ball_grid: BallGrid

var current_ball_colour: Enums.BALL_COLOUR
var current_ball_snapper: BallSnapper
var marked_snappers: Array[Vector2]

func _ready():
	SignalManager.ball_locked.connect(_on_ball_locked)
	SignalManager.ball_snapper_caught_ball.connect(_on_ball_snapper_caught_ball)
	
func _process(delta):
	if StateManager.current_state == Enums.STATE.PROCESSING:
		marked_snappers.clear()
		determine_ball_matches()
		SignalManager.processing_complete.emit()

func determine_ball_matches():
	var ball_snapper: BallSnapper = current_ball_snapper
	print("Current ball colour just shot: " + str(Enums.BALL_COLOUR.keys()[current_ball_colour]))
	print("Current snapper: " + str(ball_snapper.id) + " its ball colour: " + str(Enums.BALL_COLOUR.keys()[ball_snapper.capture_ball_colour]))
	marked_snappers.append(ball_snapper.id)
	search_for_matches(ball_snapper.id)

func search_for_matches(root_pos: Vector2):
	var topleft = root_pos - Vector2(1,1)
	var left = root_pos - Vector2(1,0)
	var bottomleft = root_pos - Vector2(1,-1)
	var bottomright = root_pos - Vector2(0,-1)
	var right = root_pos - Vector2(-1,0)
	var topright = root_pos - Vector2(0,1)
	print ("Top right is: " + str(topright))

	if ball_grid.ball_snapper_dict.find_key(str(topright)) == null:
		pass
	elif ball_grid.ball_snapper_dict.find_key(str(topright)):
		print (ball_grid.ball_snapper_dict[str(topright)].capture_ball_colour)
		if ball_grid.ball_snapper_dict[str(topright)].capture_ball_colour == current_ball_colour:
			print ("found match at " + ball_grid.ball_snapper_dict[str(topright)].id + " has ball colour " + current_ball_colour)

func _on_ball_locked(ball: Ball):
	current_ball_colour = ball.colour
	
func _on_ball_snapper_caught_ball(ball_snapper: BallSnapper):
	current_ball_snapper = ball_snapper
