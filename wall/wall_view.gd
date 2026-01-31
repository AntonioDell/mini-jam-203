extends Sprite2D


var oil_storage: HolderResource


func setup(oil_storage: HolderResource):
	self.oil_storage = oil_storage
	oil_storage.amount_changed.connect(_update_display)
	_update_display()

func _update_display(_x: int = 0):
	$StoredOilCount.text = "%s" % oil_storage.amount
