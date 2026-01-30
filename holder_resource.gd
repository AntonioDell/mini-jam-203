class_name HolderResource
extends Resource


signal amount_changed(value: int)
signal amount_change_failed


@export var amount: int = 20:
	set(value):
		amount = value
		amount_changed.emit(amount)
