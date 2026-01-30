extends Node2D

@export var olives: HolderResource

func _ready():
	var controller: OliveCollectionController = get_tree().get_first_node_in_group("OliveCollectionController")
	controller.register_desitnation(olives)
	olives.amount_changed.connect(func(amount): $Label.text = str(amount))
