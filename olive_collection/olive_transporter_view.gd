extends Node2D


var controller: OliveCollectionController
var travel: TravelResource
var olives: HolderResource

func setup(olives: HolderResource, travel: TravelResource, controller: OliveCollectionController):
	self.controller = controller
	self.travel = travel
	self.olives = olives
	olives.amount_changed.connect(_update_display)
	travel.arrived.connect(_on_travel_arrived)
	travel.path_travelled_changed.connect(_update_display)
	
	_update_display()

func _on_travel_arrived(is_returned: bool):
	if not is_returned:
		print("Arrived")
	else:
		print("Returned")
	_update_display()

func _update_display(_x = 0):
	var amount = olives.amount
	$Label.text = "%s" % amount
	var flip_offset = 3 if travel.is_returning else 0
	var new_sprite_frame = flip_offset
	var threshold_1 = controller.destination_max_amount / 2
	if amount == 0:
		new_sprite_frame += 0
	elif amount < threshold_1:
		new_sprite_frame += 1
	else:
		new_sprite_frame += 2
	$Sprite2D.frame = new_sprite_frame
