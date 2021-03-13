extends CenterContainer

func _ready():
	hide()
	for child in get_children():
		var popup = child as Popup
		popup.connect("about_to_show", self, "show")
		popup.connect("popup_hide", self, "hide")
