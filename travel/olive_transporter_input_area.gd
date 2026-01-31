class_name OliveTransporterInputArea
extends Area2D


func setup(olive_transporter: TravelResource, controller: Node):
	if "transporter_clicked" not in controller:
		GlobalErrorHandler.handle_error(self, "Setup failed, 'transporter_clicked' not in %s" % controller.name)
	
	if input_event.is_connected(_on_input_event):
		input_event.disconnect(_on_input_event)
	input_event.connect(_on_input_event.bind(olive_transporter, controller))


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int, olive_transporter: TravelResource, controller: Node):
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		controller.transporter_clicked(olive_transporter)
