class_name OliveTransporterTravelIncrementer
extends Node


@export var accelleration_curve: Curve


var travel: TravelResource
var time_to_arrival: float

func setup(travel: TravelResource, time_to_arrival: float):
	self.travel = travel
	self.time_to_arrival = time_to_arrival
	
	if travel.is_travelling:
		t = lerp(0.0, time_to_arrival, travel.path_travelled)

var t = 0.0
func _process(delta):
	if not travel.is_travelling: return
	
	var curve_sample = clampf(accelleration_curve.sample(inverse_lerp(0.0, time_to_arrival, t)), 0, 1)
	travel.path_travelled = curve_sample if not travel.is_returning else 1 - curve_sample
	var has_arrived = (not travel.is_returning and travel.path_travelled == 1.0) or (travel.is_returning and travel.path_travelled == 0.0)
	if has_arrived:
		travel.arrive()
		t = 0.0
	
	t += delta
