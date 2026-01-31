extends Node


var title_screen_scene := preload("res://title_screen.tscn")
var level_screen_scene := preload("res://level.tscn")


func _ready():
	var title_screen: TitleScreen = title_screen_scene.instantiate()
	add_child(title_screen)
	title_screen.new_game_button_pressed.connect(_on_new_game_button_pressed)
	title_screen.continue_button_pressed.connect(_on_continue_button_pressed)

func _on_new_game_button_pressed():
	GlobalSaveGameController.reset_game_state()
	_load_level()

func _on_continue_button_pressed():
	_load_level()

func _load_level():
	var title_screen = get_child(0)
	
	var level_screen = level_screen_scene.instantiate()
	add_child(level_screen)
	
	remove_child(title_screen)
