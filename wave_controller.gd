class_name WaveController
extends Node


@export var attacker_spawn_point: Node2D
@export var wave_interval := 2.0

var attacker_scene := preload("res://attacker/attacker.tscn")


func _ready():
	$Timer.wait_time = wave_interval
	$Timer.start()
	$Timer.timeout.connect(_on_timeout)

func _on_timeout():
	var attacker_controller: AttackerController = get_tree().get_first_node_in_group("AttackerController")
	_spawn_attacker()


func _spawn_attacker():
	var attacker: Attacker = attacker_scene.instantiate()
	attacker_spawn_point.add_child(attacker)
