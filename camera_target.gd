extends Node2D


var is_mouse_blocked := false



func _ready():
	$Timer.timeout.connect(_on_timeout)


func _process(delta):
	if Input.is_key_pressed(KEY_RIGHT):
		global_position.x = 1920 * 2
		is_mouse_blocked = true
		$Timer.start()
	elif Input.is_key_pressed(KEY_LEFT):
		global_position.x = 0
		is_mouse_blocked = true
		$Timer.start()
	elif not is_mouse_blocked:
		global_position = get_global_mouse_position()

func _on_timeout():
	is_mouse_blocked = false
