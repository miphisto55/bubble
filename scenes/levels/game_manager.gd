extends Node

@export var state_change_timer: Timer

func _ready():
	SignalManager.ball_shot.connect(start_timer)

func _on_state_change_timer_timeout():
	SignalManager.processing_complete.emit()

func start_timer():
	state_change_timer.start()
