class_name SettingsContainer
extends Node

signal back_button_pressed
signal main_menu_button_pressed


@export var show_main_menu_button := false:
	set(value):
		show_main_menu_button = value
		if show_main_menu_button:
			%MainMenuButton.show()
		else:
			%MainMenuButton.hide()


func _ready():
	GlobalSaveGameController.game_loaded.connect(_init_from_save_game)
	_init_from_save_game(GlobalSaveGameController.save_game_data)
	
	%MuteCheckBox.toggled.connect(_on_mute_checkbox_toggled)
	%MusicSlider.value_changed.connect(GlobalSettingsController.change_music_volume)
	%SfxSlider.value_changed.connect(GlobalSettingsController.change_sfx_volume)
	%SettingsBackButton.pressed.connect(back_button_pressed.emit)
	%MainMenuButton.pressed.connect(main_menu_button_pressed.emit)
	
	if show_main_menu_button:
		%MainMenuButton.show()
	else:
		%MainMenuButton.hide()

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
