extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Eventbus.connect("show_textbox", show)


func _unhandled_input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("close"):
			hide()
