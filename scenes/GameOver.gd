extends Control

signal back_to_menu

func _gui_input(event):
	if event.is_action("ui_accept"):
		emit_signal("back_to_menu")
