class_name WaveController
extends Node


signal next_wave_started(wave: int)
signal all_waves_done


@export var waves := [1, 5, 10, 15, 20]
@export var attacker_spawn_points: Array[Node2D] = []
@export var wave_interval := 20.0
@export var time_increase_after_wave := 2.0


var attacker_scene := preload("res://attacker/attacker.tscn")
var current_wave := 0

func _ready():
	_on_timeout()
	$Timer.timeout.connect(_on_timeout)

func _on_timeout():
	if current_wave >= waves.size():
		$Timer.stop()
		all_waves_done.emit()
		return
	var wave = waves[current_wave]
	current_wave += 1
	next_wave_started.emit(current_wave)
	
	$Timer.start(wave_interval + (current_wave * time_increase_after_wave))
	var attacker_controller: AttackerController = get_tree().get_first_node_in_group("AttackerController")
	for i in wave:
		_spawn_attacker()
		await get_tree().create_timer(.5).timeout


var t = 0
var next_spawn_point := 0
func _spawn_attacker():
	var attacker: Attacker = attacker_scene.instantiate()
	var spawn_point = attacker_spawn_points[next_spawn_point]
	attacker.name = "Attacker%s_0" % next_spawn_point
	spawn_point.add_child(attacker, true)
	next_spawn_point = pingpong(t, attacker_spawn_points.size() - 1)
	t += 1
