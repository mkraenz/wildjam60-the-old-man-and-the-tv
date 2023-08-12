extends Control

const OptionsRow = preload("res://ui/textbox/option_row.tscn")

@onready var gstate := GState
@onready var eventbus := Eventbus

@onready var options := $ScreenMargin/Padding/V/Options
@onready var label := $ScreenMargin/Padding/V/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	eventbus.connect("show_textbox", handle_show)


func _unhandled_input(event):
	if not gstate.textbox_open:
		return  # input handling should be on player if textbox is closed

	if event is InputEventKey:
		if Input.is_action_just_pressed("close"):
			print("close")
			close()


func handle_show(label_and_options: Dictionary) -> void:
	clear_options()

	label.text = label_and_options["label"]

	for i in label_and_options["options"].size():
		var option = label_and_options["options"][i]
		var option_row = OptionsRow.instantiate()
		option_row.option_text = option.label
		option_row.ordinal = i + 1  # i is zero based
		if i == 0:
			option_row.selected = true

		options.add_child(option_row)

	show()


func clear_options() -> void:
	for child in options.get_children():
		child.queue_free()


func close() -> void:
	hide()
	eventbus.textbox_hidden.emit()
