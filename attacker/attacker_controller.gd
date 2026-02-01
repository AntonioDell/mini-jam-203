class_name AttackerController
extends Node


signal attacker_dieded


var wall_health: HolderResource
var pouring_oil: HolderResource
# TODO: Make saveable
var attackers_to_damage: Array[HolderResource] = []

func register_wall_health(wall_health: HolderResource):
	self.wall_health = wall_health

func register_pouring_oil(pouring_oil: HolderResource):
	self.pouring_oil = pouring_oil
	pouring_oil.amount_delta.connect(_on_pouring_oil_amount_delta)

func attacker_arrived(attacker_health: HolderResource):
	attackers_to_damage.append(attacker_health)

func attacker_died(attacker_health: HolderResource):
	attackers_to_damage.erase(attacker_health)
	attacker_dieded.emit()

func damage_wall():
	wall_health.amount = maxi(wall_health.amount - 1, 0)

func _on_pouring_oil_amount_delta(new_value: int, old_value: int):
	if new_value >= old_value: return
	var damage_to_spread = old_value - new_value
	for health in attackers_to_damage:
		var new_health = maxi(health.amount - damage_to_spread, 0)
		health.amount = new_health
		damage_to_spread = maxi(damage_to_spread - health.amount, 0)
		if damage_to_spread == 0:
			break
