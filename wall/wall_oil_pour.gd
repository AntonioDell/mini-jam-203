extends Node2D


@export var max_flow_rate := 10
@export var time_to_max_flow_rate := 6.0

var pouring_oil: HolderResource = HolderResource.new()
var attacker_controller: AttackerController
var wall_controller: WallController


func _ready():
	pouring_oil = GlobalSaveGameController.register_holder_resource(name, pouring_oil)
	
	attacker_controller = get_tree().get_first_node_in_group("AttackerController")
	attacker_controller.register_pouring_oil(pouring_oil)
	
	wall_controller = get_tree().get_first_node_in_group("WallController")
	wall_controller.register_pouring_oil(pouring_oil)
	
	$WallOilPourView.setup(pouring_oil)
	$WallPourOilDecrementer.setup(pouring_oil, time_to_max_flow_rate, max_flow_rate)
	pouring_oil.amount_delta.connect(_on_pouring_oil_amount_delta)

func _on_pouring_oil_amount_delta(new_value: int, old_value: int):
	if new_value == 0:
		$WallPourOilDecrementer.stop_pouring()
	elif new_value > old_value:
		$WallPourOilDecrementer.start_pouring()
