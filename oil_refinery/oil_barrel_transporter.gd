class_name OilBarrelTransporter
extends PathFollow2D


@export var time_to_arrive_at_boiling_station := 2.0


var oil_barrel: HolderResource = HolderResource.new(1)
var travel: TravelResource = TravelResource.new()


func _ready():
	oil_barrel = GlobalSaveGameController.register_holder_resource(name, oil_barrel)
	travel = GlobalSaveGameController.register_travel_resource(name, travel)
	_setup_travel()
	_setup_children()
	
	travel.is_travelling = true

func _setup_travel():
	travel.arrived.connect(_on_travel_arrived)
	travel.path_travelled_changed.connect(func(value: float): progress_ratio = value)
	progress_ratio = travel.path_travelled

func _setup_children():
	$OilBarrelTransporterView.setup(oil_barrel, travel)
	$TravelIncrementer.setup(travel, time_to_arrive_at_boiling_station)


func _on_travel_arrived(is_returning: bool):
	var boiling_controller: BoilingStationController = get_tree().get_first_node_in_group("BoilingStationController")
	boiling_controller.transfer_oil_barrel_to_boiler(oil_barrel)
	GlobalSaveGameController.unregister(name)
