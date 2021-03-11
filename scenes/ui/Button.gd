tool
extends FocusButton

export var label := "Test"

onready var label_elem := $Label
onready var texture_button := $TextureButton

func _ready():
	label_elem.text = label

