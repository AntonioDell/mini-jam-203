class_name WaveController
extends Node


@export var attacker_spawn_points: Array[Node2D] = []
@export var wave_interval := 2.0

var attacker_scene := preload("res://attacker/attacker.tscn")


func _ready():
	$Timer.wait_time = wave_interval
	$Timer.start()
	$Timer.timeout.connect(_on_timeout)

func _on_timeout():
	var attacker_controller: AttackerController = get_tree().get_first_node_in_group("AttackerController")
	_spawn_attacker()

var next_spawn_point := 0
func _spawn_attacker():
	var attacker: Attacker = attacker_scene.instantiate()
	var spawn_point = attacker_spawn_points[next_spawn_point]
	attacker.name = "Attacker%s_0" % next_spawn_point
	spawn_point.add_child(attacker, true)
	next_spawn_point = pingpong(next_spawn_point + 1, attacker_spawn_points.size() - 1)
