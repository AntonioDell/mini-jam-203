class_name OilBarrelTransporterView
extends Node2D

func setup(oil_barrel: HolderResource, travel: TravelResource):
	oil_barrel.amount_changed.connect(_on_amount_changed)
	_on_amount_changed(oil_barrel.amount)
	travel.arrived.connect(_on_travel_arrived)
	travel.path_travelled_changed.connect(_on_path_travelled_changed)
	travel.travel_started.connect(_on_travel_started)

func _on_amount_changed(amount: int):
	if amount == 0:
		hide()
	else: 
		show()
	$BarrelCount.text = "%s" % amount

var did_flip = false
func _on_path_travelled_changed(amount: float):
	if not did_flip and amount >= .75:
		did_flip = true
		$AnimationPlayer.play("oil_barrel_flipping")

func _on_travel_arrived(is_returned: bool):
	$AnimationPlayer.stop()
	$AudioStreamPlayer2D.stop()

func _on_travel_started():
	$AnimationPlayer.play("oil_barrel_rolling")
	$AudioStreamPlayer2D.play()
