class_name BoilingStationController
extends Node


@export var max_heating := 100


var oil_barrel_destination: HolderResource

func register_oil_barrel_destination(oil_barrel_destination: HolderResource):
	self.oil_barrel_destination = oil_barrel_destination

func transfer_oil_barrel_to_boiler(oil_barrel: HolderResource):
	oil_barrel_destination.amount += oil_barrel.amount
	oil_barrel.amount = 0
	
