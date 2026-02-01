class_name Wall
extends Node2D


@export var health := HolderResource.new(100)
@export var max_flow_rate := 10
@export var time_to_max_flow_rate := 5.0


var oil_storage := HolderResource.new()


func _ready():
	var d = GlobalSaveGameController.register_holder_resources(name, {"oil_storage": oil_storage, "health": health})
	oil_storage = d["oil_storage"]
	health = d["health"]
	
	var wall_controller: WallController = get_tree().get_first_node_in_group("WallController")
	wall_controller.register_oil_storage(oil_storage)
	
	var attacker_controller: AttackerController = get_tree().get_first_node_in_group("AttackerController")
	attacker_controller.register_wall_health(health)
	
	var game_controller: GameController = get_tree().get_first_node_in_group("GameController")
	game_controller.register_loose_condition(health)
	
	$WallView.setup(oil_storage, health)
	$WallPourOilDecrementer.setup(oil_storage, time_to_max_flow_rate, max_flow_rate)
	$ClickInputArea.input_area_clicked.connect(func(): 
		if $WallPourOilDecrementer.is_pouring:
			$WallPourOilDecrementer.stop_pouring()
		else:
			$WallPourOilDecrementer.start_pouring()
	)
	health.amount_changed.connect(_on_health_changed)

func _on_health_changed(amount: int):
	pass
