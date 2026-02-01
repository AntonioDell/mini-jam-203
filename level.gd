extends Node2D


signal main_menu_button_pressed
signal game_lost(score: int)
signal game_won(score: int)


func _ready():
	%SettingsButton.pressed.connect(_show_settings_menu)
	%SettingsContainer.back_button_pressed.connect(_hide_settings_menu)
	%SettingsContainer.main_menu_button_pressed.connect(_on_main_menu_button_pressed)
	$GameController.game_lost.connect(_on_game_lost)
	$GameController.game_won.connect(_on_game_won)

func _show_settings_menu():
	get_tree().paused = true
	%SettingsPanel.show()
	%SettingsButton.hide()

func _hide_settings_menu():
	get_tree().paused = false
	%SettingsPanel.hide()
	%SettingsButton.show()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	GlobalSaveGameController.save()
	main_menu_button_pressed.emit()

func _on_game_lost(score: int):
	game_lost.emit(score)
	GlobalSaveGameController.reset_game_state()

func _on_game_won(score: int):
	game_won.emit(score)
	GlobalSaveGameController.reset_game_state()
