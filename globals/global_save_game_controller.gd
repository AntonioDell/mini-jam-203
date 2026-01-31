extends Node


signal game_loaded(loaded_data: SaveGameData)


const SAVE_GAME_PATH = "user://savegamedata.tres"
const DEBUG_RESET_SAVE_GAME = false

@export var save_game_data: SaveGameData


func save():
	var err := ResourceSaver.save(save_game_data, SAVE_GAME_PATH)
	if err != OK:
		GlobalErrorHandler.handle_error(self, "Failed to save game with error %s" % err)
	print("Game saved")

func reset_game_state():
	save_game_data.game_state = {}
	save()

func register_holder_resource(node_name: String, initial_holder_resource: HolderResource) -> HolderResource:
	var state = _get_saved_resources_state("holder")
	if node_name not in state:
		state[node_name] = initial_holder_resource
	state[node_name].amount_changed.connect(func(_x): _schedule_save())
	
	return state[node_name]

func register_travel_resource(node_name: String, initial_travel_resource: TravelResource) -> TravelResource:
	var state = _get_saved_resources_state("travel")
	if node_name not in state:
		state[node_name] = initial_travel_resource
	state[node_name].path_travelled_changed.connect(func(_x): _schedule_save())
	
	return state[node_name]

func _get_saved_resources_state(type: String) -> Dictionary:
	if type not in save_game_data.game_state:
		save_game_data.game_state[type] = {}
	return save_game_data.game_state[type]

func _ready():
	if not _load_save_game():
		save_game_data = SaveGameData.new()
		save()
	
	await get_tree().process_frame
	game_loaded.emit(save_game_data)

func _load_save_game() -> bool:
	if DEBUG_RESET_SAVE_GAME:
		return false
	if ResourceLoader.exists(SAVE_GAME_PATH, "SaveGameData"):
		print("Saved game exists, loading...")
		save_game_data = ResourceLoader.load(SAVE_GAME_PATH, "SaveGameData")
		return true
	return false

func _exit_tree():
	save()

var save_scheduled = false
func _schedule_save():
	if save_scheduled: return
	
	save_scheduled = true
	await get_tree().create_timer(1.0).timeout
	save()
	save_scheduled = false
	
	
