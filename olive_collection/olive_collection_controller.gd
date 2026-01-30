class_name OliveCollectionController
extends Node


@export var destination_max_amount := 150


var olive_destinations: Array[HolderResource] = []


func register_desitnation(destination: HolderResource):
	olive_destinations.append(destination)

func try_collect(source: HolderResource) -> bool:
	var destination = olive_destinations.filter(func(d: HolderResource): return d.amount < destination_max_amount)
	if source.amount > 0 and not destination.is_empty():
		_transfer(source ,destination[0])
		return true
	else:
		source.amount_change_failed.emit()
		return false

func _transfer(source: HolderResource, destination: HolderResource):
	source.amount -= 1
	destination.amount += 1
