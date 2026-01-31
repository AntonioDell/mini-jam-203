extends Node2D

func setup(olives: HolderResource, travel: TravelResource):
	olives.amount_changed.connect(_on_amount_changed)
	_on_amount_changed(olives.amount)
	travel.arrived.connect(_on_travel_arrived)

func _on_amount_changed(amount: int):
	$Label.text = "%s" % amount
	
func _on_travel_arrived(is_returned: bool):
	if not is_returned:
		print("Arrived")
	else:
		print("Returned")
