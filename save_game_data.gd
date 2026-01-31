class_name SaveGameData
extends Resource


@export var settings_data: SettingsData
@export var game_state: Dictionary

func _init():
	settings_data = SettingsData.new()
	game_state = {}
