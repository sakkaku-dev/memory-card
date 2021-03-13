extends TextureButton

export var label := "Test"
export var confirm_dialog: NodePath

onready var label_elem := $Label
onready var texture_button := $TextureButton

func _ready():
	label_elem.text = label


func _on_Button_pressed():
	if confirm_dialog:
		var dialog = get_node(confirm_dialog)
		dialog.show_modal()
