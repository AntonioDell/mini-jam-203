extends Node2D


var oil_barrel: HolderResource = HolderResource.new()


func _ready():
	oil_barrel = GlobalSaveGameController.register_holder_resource(name, oil_barrel)
	var controller: BoilingStationController = get_tree().get_first_node_in_group("BoilingStationController")
	controller.register_oil_barrel_destination(oil_barrel)
	
	$BoilingStationView.setup(oil_barrel)
