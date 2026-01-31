class_name OliveTransporter
extends PathFollow2D


@export var olives: HolderResource
@export var travel: TravelResource

var controller: OliveCollectionController

func _ready():
	olives = GlobalSaveGameController.register_holder_resource(name, olives)
	travel = GlobalSaveGameController.register_travel_resource(name, travel)
	
	controller = get_tree().get_first_node_in_group("OliveCollectionController")
	
	_setup_travel()
	_setup_children()

func _setup_travel():
	if not travel.is_travelling:
		controller.register_desitnation(olives)
	travel.arrived.connect(_on_travel_arrived)
	travel.path_travelled_changed.connect(func(value: float): progress_ratio = value)
	progress_ratio = travel.path_travelled

func _setup_children():
	$OliveTransporterView.setup(olives, travel)
	$OliveTransporterTravelIncrementer.setup(travel, 5.0)
	$OliveTransporterInputArea.olive_transporter_clicked.connect(_on_transporter_clicked)


func _on_transporter_clicked():
	print("Clicked")
	if travel.path_travelled == 1.0:
		travel.is_returning = true
	elif travel.path_travelled == 0.0:
		travel.is_returning = false
	travel.is_travelling = true
	controller.unregister_destination(olives)


func _on_travel_arrived(is_returning: bool):
	if not is_returning:
		olives.amount = 0
		print("Unloading cart")
	else:
		controller.register_desitnation(olives)
		print("Ready for more olives")
