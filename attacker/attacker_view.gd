class_name AttackerView
extends Sprite2D


var health: HolderResource
var travel: TravelResource


func setup(health: HolderResource, travel: TravelResource):
	self.health = health
	self.travel = travel
	
	travel.arrived.connect(func(_x): _update_display())
	health.amount_changed.connect(func(_x): _update_display())
	_update_display()

func start_damaging():
	$AnimationPlayer.play("attacker_damaging")


func _update_display():
	$HealthLabel.text = str(health.amount)
	pass
