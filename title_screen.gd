class_name TitleScreen
extends Node

signal new_game_button_pressed
signal continue_button_pressed

func _ready():
	if OS.has_feature("no_quit_button"):
		%QuitButton.hide()
	else:
		%QuitButton.pressed.connect(func(): get_tree().quit())
	
	_show_main_menu_buttons()
	
	%SettingsButton.pressed.connect(_show_settings)
	%SettingsBackButton.pressed.connect(_show_main_menu_buttons)
	%NewGameButton.pressed.connect(new_game_button_pressed.emit)
	
	if GlobalSaveGameController.save_game_data.game_state.is_empty():
		$%ContinueButton.hide()
	else:
		$%ContinueButton.show()
	$%ContinueButton.pressed.connect(continue_button_pressed.emit)
	
	GlobalSaveGameController.game_loaded.connect(_init_from_save_game)
	
	%MuteCheckBox.toggled.connect(_on_mute_checkbox_toggled)
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
		_enable_volume_sliders(!save_game.settings_data.is_muted)

func _on_mute_checkbox_toggled(toggle_on: bool): 
	GlobalSettingsController.toggle_muted()
	_enable_volume_sliders(!toggle_on)

func _enable_volume_sliders(enable: bool):
	%MusicSlider.editable = enable
	%SfxSlider.editable = enable
	
