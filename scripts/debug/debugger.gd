extends Control


@export var state_label: RichTextLabel

func _ready():
	SignalManager.game_state_changed.connect(_on_game_state_changed)

func _on_game_state_changed(state):
	print(state)
	state_label.text = "[center]" + str(Enums.STATE.keys()[state]) + "[/center]"
