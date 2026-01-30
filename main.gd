extends Node


var title_screen_scene := preload("res://title_screen.tscn")
var level_screen_scene := preload("res://level.tscn")

func _ready():
	var title_screen: TitleScreen = title_screen_scene.instantiate()
	add_child(title_screen)
	title_screen.start_button_pressed.connect(_on_start_button_pressed)


func _on_start_button_pressed():
	var title_screen = get_child(0)
	
	var level_screen = level_screen_scene.instantiate()
	add_child(level_screen)
	
	remove_child(title_screen)
