class_name OliveTreeInputArea
extends Area2D


func setup(olives: HolderResource, collector: Node):
	if not "try_collect" in collector:
		GlobalErrorHandler.handle_error(self, "Setup failed, 'try_collect' not in %s" % collector.name)
	
	if input_event.is_connected(_on_input_event):
		input_event.disconnect(_on_input_event)
	input_event.connect(_on_input_event.bind(olives, collector))

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int, olives: HolderResource, collector: Node):
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		collector.try_collect(olives)
