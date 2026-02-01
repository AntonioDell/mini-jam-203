class_name OilBarrelTransporterView
extends Node2D

func setup(oil_barrel: HolderResource, travel: TravelResource):
	oil_barrel.amount_changed.connect(_on_amount_changed)
	_on_amount_changed(oil_barrel.amount)
	travel.arrived.connect(_on_travel_arrived)

func _on_amount_changed(amount: int):
	if amount == 0:
		hide()
	else: 
		show()
	$BarrelCount.text = "%s" % amount
	
func _on_travel_arrived(is_returned: bool):
	print("Oil barrel arrived")
