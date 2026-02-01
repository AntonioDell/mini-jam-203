extends Node


func handle_error(source: Node, message: String):
	push_error("Error in %s: %s" % [source.name, message])
	get_tree().quit(1)
