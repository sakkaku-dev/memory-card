extends Popup

signal confirm
signal cancel

export var label_text = "Are you sure?"
onready var label = $MarginContainer/VBoxContainer/Label

onready var confirm = $MarginContainer/VBoxContainer/HBoxContainer/Confirm
onready var cancel = $MarginContainer/VBoxContainer/HBoxContainer/Cancel

func _ready():
	label.text = label_text


func _on_Confirm_pressed():
	emit_signal("confirm")


func _on_Cancel_pressed():
	hide()
	emit_signal("cancel")


func open():
	show_modal()
	confirm.grab_focus()
