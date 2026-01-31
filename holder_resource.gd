class_name HolderResource
extends Resource


signal amount_changed(new_value: int)
signal amount_change_failed
signal amount_delta(new_value: int, old_value: int)


@export var amount: int = 0:
	set(value):
		amount_delta.emit(value, amount)
		amount = value
		amount_changed.emit(amount)


func _init(initial_amount: int = 0):
	self.amount = initial_amount
