extends Control

signal back_to_menu

onready var sound = $GameOverSound

func _gui_input(event):
	if event.is_action("ui_accept"):
		emit_signal("back_to_menu")


func _on_GameOver_visibility_changed():
	if visible:
		sound.play()
