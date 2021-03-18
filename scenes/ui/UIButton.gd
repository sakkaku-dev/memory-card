extends Button

onready var press_sound = $PressSound

func _on_UIButton_mouse_entered():
	grab_focus()


func _on_UIButton_pressed():
	press_sound.play()
