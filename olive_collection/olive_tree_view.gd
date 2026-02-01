class_name OliveTreeView
extends Node2D


@onready var sprite: Sprite2D = $Sprite2D


func setup(olives: HolderResource):
	olives.amount_delta.connect(_on_olives_amount_changed)
	olives.amount_change_failed.connect(_on_olives_amount_change_failed)
	_update_visuals(olives.amount)


var current_tween: Tween 
func _on_olives_amount_changed(value: int, old_value: int):
	_update_visuals(value)
	if value >= old_value: return
	
	if current_tween and current_tween.is_running():
		current_tween.custom_step(.55)
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(sprite, "scale", Vector2(0.8,0.8), .25)
	current_tween.tween_property(sprite, "scale", Vector2(1.0,1.0), .25)
	

func _update_visuals(value: int):
	$Label.text = "%s" % value
	if value == 0:
		# TODO: Show empty tree
		$Sprite2D.modulate = Color.WHITE.darkened(.5)
	elif value <= 5:
		$Sprite2D.modulate = Color.WHITE.darkened(.25)
	else:
		# TODO: Show full tree
		$Sprite2D.modulate = Color.WHITE

func _on_olives_amount_change_failed():
	if current_tween and current_tween.is_running():
		current_tween.custom_step(.55)
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(sprite, "self_modulate", Color.RED, .25)
	current_tween.tween_property(sprite, "self_modulate", Color.WHITE, .25)
	
