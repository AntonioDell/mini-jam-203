extends Node


signal game_loaded(loaded_data: SaveGameData)


const SAVE_GAME_PATH = "user://savegamedata.tres"


@export var save_game_data: SaveGameData


func save():
	var err := ResourceSaver.save(save_game_data, SAVE_GAME_PATH)
	print("Save status: %s" % err)


func _ready():
	if not _load_save_game():
		save_game_data = SaveGameData.new()
		save()
	
	await get_tree().process_frame
	game_loaded.emit(save_game_data)

func _load_save_game() -> bool:
	if ResourceLoader.exists(SAVE_GAME_PATH, "SaveGameData"):
		print("Resource exists, loading...")
		save_game_data = ResourceLoader.load(SAVE_GAME_PATH, "SaveGameData")
		print("Loaded:\n'%s'" % JSON.stringify(save_game_data.settings_data))
		return true
	return false
