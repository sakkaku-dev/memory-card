extends TextureButton

class_name FocusButton

func _gui_input(event):
	if event.is_action("ui_accept"):
		emit_signal("pressed")
