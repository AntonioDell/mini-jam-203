extends Node2D


@export var olives: HolderResource

var controller: OliveCollectionController


func _ready():
	controller = get_tree().get_first_node_in_group("OliveCollectionController")
	_setup_children()

func _setup_children():
	$OliveTreeView.setup(olives)
	$OliveTreeInputArea.setup(olives, controller)
