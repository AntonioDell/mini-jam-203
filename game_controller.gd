class_name GameController
extends Node


var loose_condition: HolderResource


func register_loose_condition(loose_condition: HolderResource):
	self.loose_condition = loose_condition
	loose_condition.amount_changed.connect(_on_loose_condition_amount_changed)

func _on_loose_condition_amount_changed(amount: int):
	if amount == 0:
		_loose()

func _loose():
	GlobalSaveGameController.reset_game_state()
	get_tree().reload_current_scene()
