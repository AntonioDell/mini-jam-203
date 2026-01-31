class_name OliveTransporter
extends PathFollow2D


var olives: HolderResource = HolderResource.new()
var travel: TravelResource = TravelResource.new()

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
	$ClickInputArea.input_area_clicked.connect(_on_transporter_clicked)

func _on_transporter_clicked():
	if travel.path_travelled == 1.0:
		travel.is_returning = true
	elif travel.path_travelled == 0.0:
		travel.is_returning = false
		if olives.amount == 0:
			return
	travel.is_travelling = true
	controller.unregister_destination(olives)

func _on_travel_arrived(is_returning: bool):
	if not is_returning:
		var refinery_controller: OilRefineryController = get_tree().get_first_node_in_group("OilRefineryController")
		refinery_controller.transfer_olives_to_refinery(olives)
	else:
		controller.register_desitnation(olives)
