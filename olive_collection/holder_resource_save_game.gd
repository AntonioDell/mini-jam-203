extends Node


signal holder_resource_loaded(holder_resource: HolderResource)


func register_holder_resource(node_name: String, initial_holder_resource: HolderResource) -> HolderResource:	
	var state = GlobalSaveGameController.save_game_data.game_state
	if node_name in state:
		print("wow")
		holder_resource_loaded.emit(state[node_name])
	else:
		state[node_name] = initial_holder_resource
	state[node_name].amount_changed.connect(func(_x): GlobalSaveGameController.save())
	
	return state[node_name]
