extends AudioStreamPlayer

func _ready():
	if get_parent() is Control:
		var ctrl = get_parent() as Control
		ctrl.connect("focus_entered", self, "play")
