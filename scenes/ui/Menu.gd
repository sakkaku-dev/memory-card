extends Control

class_name Menu

signal menu_back

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("menu_back")


func _on_Menu_visibility_changed():
	if visible:
		for child in get_children():
			var ctrl = child as Control
			if ctrl.focus_mode != FOCUS_NONE:
				child.grab_focus()
