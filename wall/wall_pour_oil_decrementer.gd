extends Node


@export var accelleration_curve: Curve


var oil_storage: HolderResource
var is_pouring := false
var time_to_max_flow_rate: float
var max_flow_rate: float
var time_since_start = 0.0

@warning_ignore("shadowed_variable")
func setup(oil_storage: HolderResource, time_to_max_flow_rate: float, max_flow_rate: int):
	self.oil_storage = oil_storage
	self.time_to_max_flow_rate = time_to_max_flow_rate
	self.max_flow_rate = max_flow_rate

func start_pouring():
	is_pouring = true

func stop_pouring():
	is_pouring = false
	time_since_last_pour = 0
	time_between_pours = 0
	time_since_start = 0

var time_between_pours: float = 0.0
var time_since_last_pour: float = 0.0
func _process(delta):
	if not is_pouring: return
	
	var curve_sample = clampf(accelleration_curve.sample(inverse_lerp(0.0, time_to_max_flow_rate, time_since_start)), 0, 1)
	var current_flow_rate = max_flow_rate * curve_sample
	
	if time_since_last_pour >= time_between_pours:
		oil_storage.amount -= 1
		if oil_storage.amount == 0:
			stop_pouring()
		time_since_last_pour = 0.0
	
	time_between_pours = 1.0 / current_flow_rate
	time_since_last_pour += delta
	time_since_start += delta
