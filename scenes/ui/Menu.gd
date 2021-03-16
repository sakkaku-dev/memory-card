extends Control

class_name Menu

signal menu_back

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("menu_back")


func _on_Menu_visibility_changed():
	if visible and get_child_count() > 0:
		var child: Node = get_child(0)
		child.grab_focus()
