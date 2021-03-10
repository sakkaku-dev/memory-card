tool
extends Control

signal pressed

export var label := "Test"

onready var label_elem := $Label

func _ready():
	label_elem.text = label


func _on_TextureButton_pressed():
	_pressed()

func _pressed():
	emit_signal("pressed")
