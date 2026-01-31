class_name OliveTree
extends Node2D


@export var olives: HolderResource


func _ready():
	olives = GlobalSaveGameController.register_holder_resource(name, olives)
	
	_setup_children()

func _setup_children():
	var controller: OliveCollectionController = get_tree().get_first_node_in_group("OliveCollectionController")
	$ClickInputArea.input_area_clicked.connect(controller.try_collect.bind(olives))
	$OliveTreeView.setup(olives)
