class_name OilRefineryController
extends Node


@export var oil_barrel_transporter_path: Path2D
@export var refinery_capacity := 150

var refinery: OilRefinery
var oil_barrel_transporter_scene = preload("res://travel/oil_barrel_transporter.tscn")

@warning_ignore("shadowed_variable")
func register_refinery(refinery: OilRefinery):
	self.refinery = refinery

func unregister_oil_barrel_destination():
	self.oil_barrel_destination = null

func transfer_olives_to_refinery(olive_source: HolderResource):
	var max_transferrable_amount = refinery_capacity - refinery.olives.amount
	var transferred_amount = clamp(olive_source.amount, 0, max_transferrable_amount)
	refinery.olives.amount = refinery.olives.amount + transferred_amount
	olive_source.amount = olive_source.amount - transferred_amount
	if olive_source.amount != 0:
		olive_source.amount_change_failed.emit()

func refine_oil():
	var boiling_station_controller: BoilingStationController = get_tree().get_first_node_in_group("BoilingStationController")
	if not boiling_station_controller.can_accept_oil_barrel(): return
	if refinery.olives.amount < refinery_capacity: return
	
	var obt = oil_barrel_transporter_scene.instantiate()
	oil_barrel_transporter_path.add_child(obt)
	
	refinery.olives.amount = 0
