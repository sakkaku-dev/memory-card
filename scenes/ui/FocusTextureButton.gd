extends TextureButton

class_name FocusTextureButton

var press_sound

func _ready():
	connect("focus_entered", self, "_on_focus")
	connect("focus_exited", self, "_on_unfocus")
	connect("mouse_entered", self, "grab_focus")
	
	if has_node("PressSound"):
		press_sound = get_node("PressSound")
	
func _on_focus():
	modulate = Color.gray
	
func _on_unfocus():
	modulate = Color.white


func _on_FocusTextureButton_pressed():
	if press_sound:
		press_sound.play()
