class_name OliveTree
extends Node2D


@export var olives: HolderResource


func _ready():
	olives = GlobalSaveGameController.register_holder_resource(name, olives)
	_setup_children()

func _setup_children():
	var controller = get_tree().get_first_node_in_group("OliveCollectionController")
	$OliveTreeView.setup(olives)
	$OliveTreeInputArea.setup(olives, controller)
