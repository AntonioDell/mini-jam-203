extends Node2D

@export var olives: HolderResource

func _ready():
	olives = $OlivesSaveGame.register_holder_resource(name, olives)
	var controller: OliveCollectionController = get_tree().get_first_node_in_group("OliveCollectionController")
	controller.register_desitnation(olives)
	_setup_children()

func _setup_children():
	$OliveTransporterView.setup(olives)
