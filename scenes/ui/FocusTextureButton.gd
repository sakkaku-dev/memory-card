extends TextureButton

class_name FocusTextureButton

func _ready():
	connect("focus_entered", self, "_on_focus")
	connect("focus_exited", self, "_on_unfocus")
	connect("mouse_entered", self, "grab_focus")
	
func _on_focus():
	modulate = Color.gray
	
func _on_unfocus():
	modulate = Color.white
