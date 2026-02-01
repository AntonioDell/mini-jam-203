extends Node2D


signal main_menu_button_pressed


func _ready():
	%SettingsButton.pressed.connect(_show_settings_menu)
	%SettingsContainer.back_button_pressed.connect(_hide_settings_menu)
	%SettingsContainer.main_menu_button_pressed.connect(_on_main_menu_button_pressed)

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
	
