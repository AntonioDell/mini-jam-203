extends Node2D



func _process(delta):
	#global_position = get_global_mouse_position()
	if Input.is_key_pressed(KEY_RIGHT):
		global_position.x = 1920 * 2
	elif Input.is_key_pressed(KEY_LEFT):
		global_position.x = 0
