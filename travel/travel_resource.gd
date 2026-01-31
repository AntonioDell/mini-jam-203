class_name TravelResource
extends Resource


signal path_travelled_changed(new_value: float)
signal arrived(is_returned: bool)


@export var path_travelled: float = 0.0:
	set(value):
		path_travelled = value
		path_travelled_changed.emit(path_travelled)
@export var is_returning: bool = false
@export var is_travelling: bool = false


func arrive():
	arrived.emit(is_returning)
	is_returning = !is_returning
	is_travelling = false
