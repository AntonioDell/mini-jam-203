extends CanvasLayer


signal tutorial_finished


var texts: Array
var current_text := 0
var is_tutorial_finished := false

func start():
	_show_text(texts[current_text])


func _ready():
	texts = %TextContainer.get_children() 
	for t in texts:
		t.visible_characters = 0
		t.hide()
	%NextButton.pressed.connect(_on_next_button_pressed)

var t: Tween
func _show_text(text):
	var rtl = text as RichTextLabel
	rtl.visible_characters = 0
	rtl.show()
	t = create_tween()
	t.tween_property(rtl, "visible_characters", rtl.text.length(), 2.0)

func _on_next_button_pressed():
	if is_tutorial_finished: return
	if t.is_running():
		t.custom_step(100000)
		return
	texts[current_text].hide()
	current_text += 1
	if current_text >= texts.size():
		tutorial_finished.emit()
		is_tutorial_finished = true
		return
	_show_text(texts[current_text])
