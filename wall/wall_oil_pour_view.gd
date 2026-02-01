extends Sprite2D


var pouring_oil: HolderResource


func setup(pouring_oil: HolderResource):
	self.pouring_oil = pouring_oil
	pouring_oil.amount_changed.connect(func(_x): _update_display())
	pouring_oil.amount_delta.connect(_on_amount_delta)
	$Timer.timeout.connect(_on_timeout)
	_update_display()

func _update_display():
	$OilPourLabel.text = str(pouring_oil.amount)
	if pouring_oil.amount == 0:
		hide()
	else:
		show()

func _on_amount_delta(new_value: int, old_value: int):
	#if old_value == 0 and new_value > 0:
		#show()
		#$AnimationPlayer.play("oil_pour_start")
		#await $AnimationPlayer.animation_finished
		#$AnimationPlayer.play("oil_pour_loop")
	#elif new_value == 0 and old_value > 0:
		#$Timer.start(1.0)
		#hide()
	pass

func _on_timeout():
	print("wow")
	$AnimationPlayer.play("oil_pour_end")
	await $AnimationPlayer.animation_finished
	hide()
