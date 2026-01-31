class_name HolderResource
extends Resource


signal amount_changed(new_value: int)
signal amount_change_failed


@export var amount: int = 0:
	set(value):
		amount = value
		amount_changed.emit(amount)
