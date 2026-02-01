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
	%SettingsContainer.back_button_pressed.connect(_show_main_menu_buttons)
	%NewGameButton.pressed.connect(new_game_button_pressed.emit)
	
	# FIXME: Reloading dynamic entities does not yet work well
	#if GlobalSaveGameController.save_game_data.game_state.is_empty():
	#	$%ContinueButton.hide()
	#else:
	#	$%ContinueButton.show()
	%ContinueButton.hide()
	$%ContinueButton.pressed.connect(continue_button_pressed.emit)

func _show_settings():
	%MainMenuButtonsContainer.hide()
	%SettingsContainer.show()

func _show_main_menu_buttons():
	%MainMenuButtonsContainer.show()
	%SettingsContainer.hide()
