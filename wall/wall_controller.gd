class_name WallController
extends Node


@export var oil_per_barrel := 100
@export var max_flow_rate := 10
@export var time_to_max_flow_rate := 5.0

var oil_storage: HolderResource


func register_oil_storage(oil_storage: HolderResource):
	self.oil_storage = oil_storage

func try_transfer_heated_oil_to_destination(oil_barrel: HolderResource, heat_applied: HolderResource):
	if heat_applied.amount < 50: 
		# TODO: Show not enough heat
		return
	oil_storage.amount += oil_barrel.amount * oil_per_barrel
	oil_barrel.amount = 0
	# TODO: Currently we don't care about the heat -> this needs to change
	heat_applied.amount = 0
