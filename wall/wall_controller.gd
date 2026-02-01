class_name WallController
extends Node


@export var oil_per_barrel := 100

var oil_storage: HolderResource
var pouring_oil: HolderResource


func register_oil_storage(oil_storage: HolderResource):
	self.oil_storage = oil_storage
	oil_storage.amount_delta.connect(_on_oil_amount_delta)

func register_pouring_oil(pouring_oil: HolderResource):
	self.pouring_oil = pouring_oil

func try_transfer_heated_oil_to_destination(oil_barrel: HolderResource, heat_applied: HolderResource):
	if heat_applied.amount < 50: 
		# TODO: Show not enough heat
		return
	oil_storage.amount += oil_barrel.amount * oil_per_barrel
	oil_barrel.amount = 0
	# TODO: Currently we don't care about the heat -> this needs to change
	heat_applied.amount = 0

func _on_oil_amount_delta(new_value: int, old_value: int):
	if new_value >= old_value: return
	pouring_oil.amount += old_value - new_value
