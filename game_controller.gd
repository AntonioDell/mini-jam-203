class_name GameController
extends Node


signal game_lost(score: int)
signal game_won(score: int)


@export var attacker_controller: AttackerController
@export var wave_controller: WaveController

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
	wave_controller.next_wave_started.connect(_on_next_wave_started)
	wave_controller.all_waves_done.connect(_on_all_waves_done)
	
	%UI.hide()
	%Tutorial.start()
	%Tutorial.tutorial_finished.connect(_on_tutorial_finished)

func _on_loose_condition_amount_changed(amount: int):
	if amount == 0:
		_loose()

func _loose():
	game_lost.emit(score.amount)

func _increase_score():
	score.amount += 1

func _on_next_wave_started(wave: int):
	%WaveCount.text = str(wave)

func _on_all_waves_done():
	game_won.emit(score.amount)

func _on_tutorial_finished():
	(%Tutorial.get_child(0) as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Tutorial.hide()
	%UI.show()
	wave_controller.start_waves()
