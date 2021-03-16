extends Control

var ignore = false

func _ready():
	for child in get_children():
		var c = child as Control
		c.hide()
		c.connect("visibility_changed", self, "on_menu_shown", [c])
	
	if get_child_count() > 0:
		get_child(0).show()

func on_menu_shown(menu: Control) -> void:
	if ignore: return
	
	ignore = true
	for child in get_children():
		if child != menu:
			child.hide()
	ignore = false
