extends Node


signal heating_done


@export var accelleration_curve: Curve


var heat_applied: HolderResource
var time_to_max_heat: float
var max_heating: float
var is_heating := false
var t = 0.0

func setup(heat_applied: HolderResource, time_to_max_heat: float, max_heating: int):
	self.heat_applied = heat_applied
	self.time_to_max_heat = time_to_max_heat
	self.max_heating = max_heating
	
	if heat_applied.amount > 0:
		t = inverse_lerp(0.0, max_heating, heat_applied.amount) * time_to_max_heat
		start_heating()

func start_heating():
	is_heating = true

func stop_heating():
	is_heating = false
	t = 0.0

func _process(delta):
	if not is_heating: return
	
	var curve_sample = clampf(accelleration_curve.sample(inverse_lerp(0.0, time_to_max_heat, t)), 0, 1)
	heat_applied.amount = clampi(curve_sample * max_heating, 0, max_heating)
	var done_heating = heat_applied.amount == max_heating
	if done_heating:
		heating_done.emit()
		stop_heating()
	
	t += delta
