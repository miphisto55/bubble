extends Node

var current_state = Enums.STATE.AIMING

func _ready():
	SignalManager.ball_shot.connect(change_state_to_shooting)
	SignalManager.ball_locked.connect(change_state_to_processing)
	SignalManager.processing_complete.connect(change_state_to_aiming)
	
func change_state_to_shooting():
	current_state = Enums.STATE.SHOOTING
	SignalManager.game_state_changed.emit(Enums.STATE.SHOOTING)

func change_state_to_processing(ball):
	current_state = Enums.STATE.PROCESSING
	SignalManager.game_state_changed.emit(Enums.STATE.PROCESSING)
	
func change_state_to_aiming():
	current_state = Enums.STATE.AIMING
	SignalManager.game_state_changed.emit(Enums.STATE.AIMING)
