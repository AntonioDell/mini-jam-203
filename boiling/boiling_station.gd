extends Node2D


var oil_barrel: HolderResource = HolderResource.new()
var heat_applied: HolderResource = HolderResource.new()


func _ready():
	var d = {"oil_barrel": oil_barrel, "heat_applied": heat_applied}
	d = GlobalSaveGameController.register_holder_resources(name, d)
	oil_barrel = d["oil_barrel"]
	heat_applied = d["heat_applied"]
	
	var controller: BoilingStationController = get_tree().get_first_node_in_group("BoilingStationController")
	controller.register_oil_barrel_destination(oil_barrel)
	
	$ClickInputArea.input_area_clicked.connect(_on_input_area_clicked)
	$BoilingStationView.setup(oil_barrel, heat_applied, controller.max_heating)
	$BoilingStationHeatingIncrementer.setup(heat_applied, 10.0, controller.max_heating)
	
	$BoilingStationHeatingIncrementer.heating_done.connect(_on_heating_done)
	oil_barrel.amount_changed.connect(_on_oil_barrel_amount_changed)

func _on_oil_barrel_amount_changed(amount: int):
	if amount > 0:
		$BoilingStationHeatingIncrementer.start_heating()
	else: 
		$BoilingStationHeatingIncrementer.stop_heating()

func _on_heating_done():
	oil_barrel.amount = 0

func _on_input_area_clicked():
	var wall_controller: WallController = get_tree().get_first_node_in_group("WallController")
	wall_controller.try_transfer_heated_oil_to_destination(oil_barrel, heat_applied)
		
