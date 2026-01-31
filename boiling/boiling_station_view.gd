extends Sprite2D


var oil_barrel: HolderResource
var heat_applied: HolderResource
var max_heating: int

func setup(oil_barrel: HolderResource, heat_applied: HolderResource, max_heating: int):
	self.oil_barrel = oil_barrel
	self.heat_applied = heat_applied
	self.max_heating = max_heating
	oil_barrel.amount_changed.connect(_update_display)
	heat_applied.amount_changed.connect(_update_display)
	_update_display()

func _update_display(_x: int = 0):
	if oil_barrel.amount == 0:
		$State.text = "Empty"
		return
	$State.text = "Heating: %s/%s" %[heat_applied.amount, max_heating]
	
