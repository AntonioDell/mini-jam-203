extends Sprite2D


func setup(oil_barrel: HolderResource):
	oil_barrel.amount_changed.connect(_on_oil_barrel_amount_changed)

func _on_oil_barrel_amount_changed(amount: int):
	if amount == 0:
		$FilledState.text = "Empty"
	else:
		$FilledState.text = "Full"
