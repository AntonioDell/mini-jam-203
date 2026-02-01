extends Node


var olives: HolderResource
var replenish_rate: float
var max_olives: int


func setup(olives: HolderResource, replenish_rate: float, max_olives: int):
	self.olives = olives
	self.replenish_rate = replenish_rate
	self.max_olives = max_olives
	olives.amount_delta.connect(_on_olives_amount_delta)
	$Timer.start(replenish_rate)

func _ready():
	$Timer.timeout.connect(func(): 
		olives.amount = min(olives.amount + 1, max_olives)
	)

func _on_olives_amount_delta(new_value: int, old_value: int):
	if new_value < old_value:
		$Timer.start(replenish_rate)
