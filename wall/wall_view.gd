extends Sprite2D


var oil_storage: HolderResource
var health: HolderResource


func setup(oil_storage: HolderResource, health: HolderResource):
	self.oil_storage = oil_storage
	self.health = health
	oil_storage.amount_changed.connect(_update_display)
	health.amount_changed.connect(_update_display)
	_update_display()

func _update_display(_x: int = 0):
	%StoredOilCount.text = "%s" % oil_storage.amount
	%HealthCount.text = "%s" % health.amount
