extends Node2D


var controller: OliveCollectionController
var travel: TravelResource
var olives: HolderResource


func setup(olives: HolderResource, travel: TravelResource, controller: OliveCollectionController):
	self.controller = controller
	self.travel = travel
	self.olives = olives
	olives.amount_changed.connect(_update_cart_display)
	travel.arrived.connect(_on_travel_arrived)
	travel.path_travelled_changed.connect(_on_travel_changed)
	
	_update_cart_display()


func _on_travel_changed(amount: float):
	if amount != 0.0 and amount != 1.0 and not $AnimationPlayer.is_playing():
		if not travel.is_returning:
			$AnimationPlayer.play("push_cart_right")
			$AudioStreamPlayer2D.play()
		else:
			$AnimationPlayer.play("push_cart_left")
			$AudioStreamPlayer2D.play()
		
	_update_cart_display()

func _on_travel_arrived(is_returned: bool):
	$AnimationPlayer.stop()
	$AudioStreamPlayer2D.stop()
	_update_cart_display()

func _update_cart_display(_x = 0):
	var amount = olives.amount
	$Label.text = "%s" % amount
	
	var flip_offset = 0 if travel.is_returning else 3
	var new_sprite_frame = flip_offset
	var threshold_1 = controller.destination_max_amount / 2
	if amount == 0:
		new_sprite_frame += 0
	elif amount < threshold_1:
		new_sprite_frame += 1
	else:
		new_sprite_frame += 2
	$Cart.frame = new_sprite_frame
	if flip_offset > 0:
		pass
