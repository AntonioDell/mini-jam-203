extends Node


var title_screen_scene := preload("res://title_screen.tscn")
var level_screen_scene := preload("res://level.tscn")
var credits_screen_scene := preload("res://credits.tscn")


func _ready():
	_load_title_screen()

func _on_new_game_button_pressed():
	GlobalSaveGameController.reset_game_state()
	_load_level()

func _on_continue_button_pressed():
	_load_level()

func _load_level():
	if get_child_count() > 0:
		remove_child(get_child(0))
	
	var level_screen = level_screen_scene.instantiate()
	add_child(level_screen)
	level_screen.main_menu_button_pressed.connect(_load_title_screen)
	level_screen.game_lost.connect(_on_game_lost)
	level_screen.game_won.connect(_on_game_won)

func _load_title_screen():
	if get_child_count() > 0:
		remove_child(get_child(0))
	
	var title_screen: TitleScreen = title_screen_scene.instantiate()
	add_child(title_screen)
	title_screen.new_game_button_pressed.connect(_on_new_game_button_pressed)
	title_screen.continue_button_pressed.connect(_on_continue_button_pressed)

func _on_game_lost(score: int):
	if get_child_count() > 0:
		remove_child(get_child(0))
	
	var credits_screen = credits_screen_scene.instantiate()
	credits_screen.score = score
	credits_screen.play_again_button_pressed.connect(_load_level)
	add_child(credits_screen)

func _on_game_won(score: int):
	if get_child_count() > 0:
		remove_child(get_child(0))
	
	var credits_screen: Credits = credits_screen_scene.instantiate()
	credits_screen.score = score
	credits_screen.won = true
	credits_screen.play_again_button_pressed.connect(_load_level)
	add_child(credits_screen)
	
