class_name TravelResource
extends Resource


signal travel_started()
signal path_travelled_changed(new_value: float)
signal arrived(is_returned: bool)


@export var path_travelled: float = 0.0:
	set(value):
		path_travelled = value
		path_travelled_changed.emit(path_travelled)
@export var is_returning: bool = false
@export var is_travelling: bool = false:
	set(value):
		if not is_travelling and value:
			travel_started.emit()
		is_travelling = value


func arrive():
	arrived.emit(is_returning)
	is_returning = !is_returning
	is_travelling = false
