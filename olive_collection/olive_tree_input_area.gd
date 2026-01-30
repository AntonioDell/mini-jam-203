class_name OliveTreeInputArea
extends Area2D


var olives: HolderResource
var collector


func setup(olives: HolderResource, collector):
	if not "try_collect" in collector:
		push_error("Setup failed, collector needs function 'try_collect'")
		get_tree().quit(1)
	self.olives = olives
	self.collector = collector

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		collector.try_collect(olives)
