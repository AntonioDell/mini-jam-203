extends Node


signal play_again_button_pressed


@export var score: int

func _ready():
	%ScoreLabel.text = %ScoreLabel.text.replace("<here>", str(score))
	%PlayAgainButton.pressed.connect(play_again_button_pressed.emit)
