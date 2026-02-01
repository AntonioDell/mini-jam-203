class_name GameController
extends Node


signal game_lost(score: int)


@export var attacker_controller: AttackerController

var score: HolderResource = HolderResource.new()
var loose_condition: HolderResource

func register_loose_condition(loose_condition: HolderResource):
	self.loose_condition = loose_condition
	loose_condition.amount_changed.connect(_on_loose_condition_amount_changed)


func _ready():
	score = GlobalSaveGameController.register_holder_resource(name, score)
	attacker_controller.attacker_dieded.connect(_increase_score)
	
	score.amount_changed.connect(func(amount: int):
		%ScoreCount.text = str(amount)
	)

func _on_loose_condition_amount_changed(amount: int):
	if amount == 0:
		_loose()

func _loose():
	game_lost.emit(score.amount)

func _increase_score():
	score.amount += 1
