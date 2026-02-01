extends Node


var controller: AttackerController


func setup(controller: AttackerController, damage_interval: float):
	self.controller = controller
	$Timer.wait_time = damage_interval

func start_damaging():
	$Timer.start()

func _ready():
	$Timer.timeout.connect(_on_timeout)

func _on_timeout():
	controller.damage_wall()
