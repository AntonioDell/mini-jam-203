class_name TravelResource
extends Resource


signal path_travelled_changed(new_value: float)
signal arrived(is_returned: bool)


@export var path_travelled: float = 0.0
