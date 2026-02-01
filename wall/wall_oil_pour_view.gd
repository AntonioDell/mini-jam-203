extends Sprite2D


var pouring_oil: HolderResource


func setup(pouring_oil: HolderResource):
	self.pouring_oil = pouring_oil
	pouring_oil.amount_changed.connect(func(_x): _update_display())
	_update_display()

func _update_display():
	if pouring_oil.amount == 0:
		hide()
	else:
		show()
	$OilPourLabel.text = str(pouring_oil.amount)
