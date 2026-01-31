class_name ClickInputArea
extends Area2D


signal input_area_clicked
signal input_area_released

func _ready():
	mouse_entered.connect(func(): is_mouse_hovering = true)
	mouse_exited.connect(func(): 
		is_mouse_hovering = false
		if is_click_in_progress:
			input_area_released.emit()
		is_click_in_progress = false
	)


var is_mouse_hovering = false
var is_click_in_progress = false

func _process(delta):
	if not is_mouse_hovering: return
	
	if Input.is_action_just_pressed("interact"):
		input_area_clicked.emit()
		is_click_in_progress = true
	elif is_click_in_progress and Input.is_action_just_released("interact"):
		input_area_released.emit()
		is_click_in_progress = false
