class_name OilRefinery
extends Node2D


var olives: HolderResource = HolderResource.new()
var controller: OilRefineryController


func _ready():
	controller = get_tree().get_first_node_in_group("OilRefineryController")
	controller.register_refinery(self)
	$ClickInputArea.input_area_clicked.connect(_on_input_area_clicked)
	
	olives = GlobalSaveGameController.register_holder_resource(name,  olives)
	
	_setup_children()

func _setup_children():
	$OilRefineryView.setup(olives, controller)


func _on_input_area_clicked():
	if not controller.can_refine(): return
	await $OilRefineryView.play_olive_press_animation()
	controller.refine_oil()
