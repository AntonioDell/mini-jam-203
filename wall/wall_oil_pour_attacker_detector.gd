extends Area2D


var pouring_oil: HolderResource


func setup(pouring_oil: HolderResource):
	self.pouring_oil = pouring_oil
	pouring_oil.amount_changed.connect(_on_pouring_oil_amount_changed)


func _on_pouring_oil_amount_changed(_x: int):
	if pouring_oil.amount == 0:
		set_deferred("monitoring", false)
	elif not monitoring:
		set_deferred("monitoring", true)
