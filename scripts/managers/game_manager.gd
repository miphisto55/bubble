class_name GameManager
extends Node

func _ready():
	SignalManager.balls_stopped.connect(_on_balls_stopped_moving)

func _on_balls_stopped_moving():
	SignalManager.processing_complete.emit()
