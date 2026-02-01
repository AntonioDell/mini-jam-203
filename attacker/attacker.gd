class_name Attacker
extends PathFollow2D


@export var health_amount := 5
@export var time_to_arrive_at_wall := 10.0
@export var damage_interval := 1.0

@onready var health := HolderResource.new(health_amount)
@onready var travel := TravelResource.new()
var controller: AttackerController

func _ready():
	health = GlobalSaveGameController.register_holder_resource(name, health)
	travel = GlobalSaveGameController.register_travel_resource(name, travel)
	controller = get_tree().get_first_node_in_group("AttackerController")
	
	$AttackerView.setup(health, travel)
	$TravelIncrementer.setup(travel, time_to_arrive_at_wall)
	$WallDamager.setup(controller, damage_interval)
	_setup_travel()
	health.amount_changed.connect(_on_health_changed)

func _setup_travel():
	travel.arrived.connect(_on_travel_arrived)
	travel.path_travelled_changed.connect(func(value: float): progress_ratio = value)
	progress_ratio = travel.path_travelled
	travel.is_travelling = true

func _on_travel_arrived(_x: bool):
	controller.attacker_arrived(health)
	$AttackerView.start_damaging()
	$WallDamager.start_damaging()

func _on_health_changed(_x: int):
	if health.amount == 0:
		# die
		controller.attacker_died(health)
		GlobalSaveGameController.unregister(name)
		queue_free()
