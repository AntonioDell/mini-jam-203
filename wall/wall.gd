class_name Wall
extends Node2D


var oil_storage := HolderResource.new()


func _ready():
	oil_storage = GlobalSaveGameController.register_holder_resource(name, oil_storage)
	
	var controller: WallController = get_tree().get_first_node_in_group("WallController")
	controller.register_oil_storage(oil_storage)
	
	$WallView.setup(oil_storage)
	$WallPourOilDecrementer.setup(oil_storage, controller.time_to_max_flow_rate, controller.max_flow_rate)
	$ClickInputArea.input_area_clicked.connect($WallPourOilDecrementer.start_pouring)
	$ClickInputArea.input_area_released.connect($WallPourOilDecrementer.stop_pouring)
