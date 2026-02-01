class_name Credits
extends Node


signal play_again_button_pressed


@export var score: int
@export var won: bool


func _ready():
	if won:
		%ThankYouLabel.hide()
		%CongratulationsLabel.show()
	else:
		%ThankYouLabel.show()
		%CongratulationsLabel.hide()
	%ScoreLabel.text = %ScoreLabel.text.replace("<here>", str(score))
	%PlayAgainButton.pressed.connect(play_again_button_pressed.emit)
