class_name OilRefineryView
extends Node2D


var olives: HolderResource
var show_disabled_olives_count: int

func setup(olives: HolderResource, show_disabled_olives_count: int):
	self.olives = olives
	self.show_disabled_olives_count = show_disabled_olives_count
	olives.amount_changed.connect(_update_visuals)
	_update_visuals()

func _on_olives_amount_changed(_value: int):
	_update_visuals()

func _update_visuals(_x: int = 0):
	%OlivesCount.text = str(olives.amount)
	
	if olives.amount < show_disabled_olives_count:
		$Sprite2D.modulate = Color.DARK_GRAY
	else:
		$Sprite2D.modulate = Color.WHITE
