class_name OliveTree
extends Node2D


@export var olives: HolderResource
@export var replenish_rate := 2.0
@export var max_olives := 30

var controller: OliveCollectionController

func _ready():
	olives = GlobalSaveGameController.register_holder_resource(name, olives)
	
	_setup_children()

func _setup_children():
	controller = get_tree().get_first_node_in_group("OliveCollectionController")
	$ClickInputArea.input_area_clicked.connect(_on_input_area_clicked)
	$OliveTreeView.setup(olives)
	$OliveTreeReplenisher.setup(olives, replenish_rate, max_olives)

func _on_input_area_clicked():
	controller.try_collect(olives)
