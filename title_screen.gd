class_name TitleScreen
extends Node

signal start_button_pressed

func _ready():
	if OS.has_feature("no_quit_button"):
		%QuitButton.hide()
	else:
		%QuitButton.pressed.connect(func(): get_tree().quit())
	
	_show_main_menu_buttons()
	
	%SettingsButton.pressed.connect(_show_settings)
	%SettingsBackButton.pressed.connect(_show_main_menu_buttons)
	%StartButton.pressed.connect(start_button_pressed.emit)
	
	GlobalSaveGameController.game_loaded.connect(_init_from_save_game)
	_init_from_save_game(GlobalSaveGameController.save_game_data)
	
	%MuteCheckBox.toggled.connect(func(toggle_on: bool): 
		GlobalSettingsController.toggle_muted()
		%MusicSlider.editable = !toggle_on
		%SfxSlider.editable = !toggle_on
	)
	%MusicSlider.value_changed.connect(GlobalSettingsController.change_music_volume)
	%SfxSlider.value_changed.connect(GlobalSettingsController.change_sfx_volume)


func _show_settings():
	%MainMenuButtonsContainer.hide()
	%SettingsContainer.show()

func _show_main_menu_buttons():
	%MainMenuButtonsContainer.show()
	%SettingsContainer.hide()

func _init_from_save_game(save_game: SaveGameData):
		%MusicSlider.value = save_game.settings_data.music_volume
		%SfxSlider.value = save_game.settings_data.sfx_volume
		%MuteCheckBox.set_pressed_no_signal(save_game.settings_data.is_muted)
