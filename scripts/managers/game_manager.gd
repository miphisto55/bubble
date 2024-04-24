class_name GameManager
extends Node

@export var ball_grid: BallGrid

var current_ball_colour: Enums.BALL_COLOUR = Enums.BALL_COLOUR.DEEP_BLUE
var current_ball_snapper: BallSnapper = null

var visited_nodes: Array[Vector2i]

func _ready():
	SignalManager.ball_locked.connect(_on_ball_locked)
	SignalManager.ball_snapper_caught_ball.connect(_on_ball_snapper_caught_ball)
	
func _process(delta):
	if StateManager.current_state == Enums.STATE.PROCESSING:
		determine_ball_matches()
		SignalManager.processing_complete.emit()

func determine_ball_matches():
	if current_ball_snapper == null:
		return
	
	visited_nodes.clear()
	var ball_snapper: BallSnapper = current_ball_snapper
	print("Current snapper: " + str(ball_snapper.id) + " its ball colour: " + str(Enums.BALL_COLOUR.keys()[ball_snapper.capture_ball_colour]))
	visited_nodes.append(ball_snapper.id)
	search_for_matches(ball_snapper.id)
	
	if visited_nodes.size() >= 3:
		print ("Found: " + str(visited_nodes))
		SignalManager.clear_matching_balls.emit(visited_nodes)

func search_for_matches(root_pos: Vector2i):
	var topleft = root_pos - Vector2i(1,1)
	var left = root_pos - Vector2i(1,0)
	var bottomleft = root_pos - Vector2i(1,-1)
	var bottomright = root_pos - Vector2i(0,-1)
	var right = root_pos - Vector2i(-1,0)
	var topright = root_pos - Vector2i(0,1)
	
	var positions_to_check: Array[Vector2i]
	positions_to_check.append(topleft)
	positions_to_check.append(left)
	positions_to_check.append(bottomleft)
	positions_to_check.append(bottomright)
	positions_to_check.append(right)
	positions_to_check.append(topright)
	
	for pos_vector in positions_to_check:
		check_if_searchable(pos_vector)

func check_if_searchable(pos: Vector2i):
	var snapper_exists = ball_grid.ball_snapper_dict.has(pos)
	if snapper_exists:
		var snapper_colour = ball_grid.ball_snapper_dict[pos].capture_ball_colour
		var can_search = snapper_colour == current_ball_colour
		if can_search and !visited_nodes.has(pos):
			visited_nodes.append(pos)
			search_for_matches(pos)

func _on_ball_locked(ball: Ball):
	current_ball_colour = ball.colour

func _on_ball_snapper_caught_ball(ball_snapper: BallSnapper):
	current_ball_snapper = ball_snapper
