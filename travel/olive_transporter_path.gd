class_name OliveTransporterPath
extends Path2D


var transporters: Array[OliveTransporter] = []


func start_travel(olive_transporter: OliveTransporter):
	if transporters.any(func(ot): return ot == olive_transporter): return
	
	transporters.append(olive_transporter)
	var pf = PathFollow2D.new()
	


func _ready():
	var controller: OliveTransporterTravelController = get_tree().get_first_node_in_group("OliveTransporterTravelController")
	controller.register_path(self)
