extends Control

const OptionsRow = preload("res://ui/textbox/option_row.tscn")

@onready var gstate := GState
@onready var eventbus := Eventbus

@onready var options := $ScreenMargin/Padding/V/Options
@onready var label := $ScreenMargin/Padding/V/Label

var selected_option_index := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	eventbus.connect("show_textbox", handle_show)
	eventbus.connect("close_textbox", close)


func _unhandled_input(event):
	if not gstate.textbox_open:
		return  # input handling should be on player if textbox is closed

	if event is InputEventKey:
		if Input.is_action_just_pressed("close"):
			close()

		if Input.is_action_just_pressed("move_down"):
			var children = options.get_children()
			children[selected_option_index].unselect()
			selected_option_index = (selected_option_index + 1) % children.size()
			children[selected_option_index].select()

		if Input.is_action_just_pressed("move_up"):
			var children = options.get_children()
			children[selected_option_index].unselect()
			selected_option_index = (selected_option_index - 1) % children.size()
			children[selected_option_index].select()

		if Input.is_action_just_pressed("confirm"):
			var children = options.get_children()
			children[selected_option_index].confirm()


func handle_show(label_and_options: Dictionary) -> void:
	clear_options()

	label.text = label_and_options["label"]

	var quit_options_row = make_options_row(
		{"label": "Leave", "event_name_on_selected": "close_textbox"}, 0
	)
	options.add_child(quit_options_row)

	for i in label_and_options["options"].size():
		var option: Dictionary = label_and_options["options"][i]
		var option_row := make_options_row(option, i + 1)
		options.add_child(option_row)

	show()

	get_viewport().set_input_as_handled()  # without this the move_up input handler in _unhandled_input(..) will be triggered and cause the cursor to move up immediately on walking into the object


func clear_options() -> void:
	selected_option_index = 0
	for child in options.get_children():
		child.queue_free()


func make_options_row(option: Dictionary, ordinal: int) -> Control:
	var options_row = OptionsRow.instantiate()
	options_row.option_text = option.label
	options_row.ordinal = ordinal
	options_row.on_confirm = func(): eventbus.emit_signal(option.event_name_on_selected)
	if ordinal == 0:
		options_row.selected = true
	return options_row


func close() -> void:
	hide()
	eventbus.textbox_hidden.emit()
