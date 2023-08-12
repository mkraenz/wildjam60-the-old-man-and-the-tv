extends Control

@onready var gstate := GState
@onready var eventbus := Eventbus


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	eventbus.connect("show_textbox", show)


func _unhandled_input(event):
	if not gstate.textbox_open:
		return  # input handling should be on player if textbox is closed

	if event is InputEventKey:
		if Input.is_action_just_pressed("close"):
			print("close")
			close()


func close() -> void:
	hide()
	eventbus.textbox_hidden.emit()
