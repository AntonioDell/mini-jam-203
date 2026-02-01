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

var did_last_one_burn_down := false
func _update_display(_x: int = 0):
	if oil_barrel.amount == 0:
		$OilBarrelSprite.hide()
		$State.text = "Empty" if not did_last_one_burn_down else "Burnt :("
		return
	$OilBarrelSprite.show()
	
	var heating_thresholds = max_heating / 4
	
	if heat_applied.amount == max_heating:
		did_last_one_burn_down = true
	elif heat_applied.amount >= heating_thresholds * 3:
		$State.text = "IT'S BOILING!!!"
	elif heat_applied.amount >= heating_thresholds * 2:
		$State.text = "That is HOT"
	elif heat_applied.amount >= heating_thresholds:
		$State.text = "Getting warmer..."
	else:
		did_last_one_burn_down = false
		$State.text = "Cold pressed"
	
