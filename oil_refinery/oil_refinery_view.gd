class_name OilRefineryView
extends Node2D


var olives: HolderResource
var show_disabled_olives_count: int
var controller: OilRefineryController

func setup(olives: HolderResource, controller: OilRefineryController):
	self.controller = controller
	self.olives = olives
	self.show_disabled_olives_count = show_disabled_olives_count
	olives.amount_changed.connect(_update_visuals)
	_update_visuals()

func play_olive_press_animation():
	$AnimationPlayer.play("oil_refinery_press")
	return $AnimationPlayer.animation_finished


func _update_visuals(_x: int = 0):
	%OlivesCount.text = "%s/%s" % [olives.amount, controller.refinery_capacity]
	
	if olives.amount >= controller.refinery_capacity:
		$Sprite2D.frame = 1
	else:
		$Sprite2D.frame = 0
