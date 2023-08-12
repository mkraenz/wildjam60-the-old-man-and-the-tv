extends Node

@export var textbox_open := false  # decides whether to use textbox input or player input

var eventbus := Eventbus


func _ready():
	eventbus.connect("textbox_hidden", on_textbox_closed)


func open_textbox() -> void:
	textbox_open = true
	eventbus.show_textbox.emit()


func on_textbox_closed() -> void:
	print("textbox closed")
	textbox_open = false
