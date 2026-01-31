class_name ClickInputArea
extends Area2D


signal input_area_clicked


func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		input_area_clicked.emit()
