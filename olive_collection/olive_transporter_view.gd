extends Node2D

func setup(olives: HolderResource):
	olives.amount_changed.connect(_on_amount_changed)
	_on_amount_changed(olives.amount)

func _on_amount_changed(amount: int):
	$Label.text = "%s" % amount
	
