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
