extends Node

@export var settings_data: SettingsData


func change_music_volume(value: float):
	settings_data.music_volume = value
	_set_settings_to_audio_busses()

func change_sfx_volume(value: float):
	settings_data.sfx_volume = value
	_set_settings_to_audio_busses()

func toggle_muted():
	settings_data.is_muted = !settings_data.is_muted
	_set_settings_to_audio_busses()


func _ready():
	GlobalSaveGameController.game_loaded.connect(_init_settings_data)
	if GlobalSaveGameController.save_game_data:
		_init_settings_data(GlobalSaveGameController.save_game_data)


func _set_settings_to_audio_busses(skip_save: bool = false):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), settings_data.music_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Sfx"), settings_data.sfx_volume)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), settings_data.is_muted)
	
	GlobalSaveGameController.save_game_data.settings_data = settings_data
	GlobalSaveGameController.save()

func _init_settings_data(save_game: SaveGameData):
		settings_data = save_game.settings_data
		_set_settings_to_audio_busses(true)
