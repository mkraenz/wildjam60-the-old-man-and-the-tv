extends HBoxContainer

@export var option_text := ""
@export var ordinal := 1
@export var selected := false

@onready var label := $OptionLabel
@onready var ordinal_label := $Ordinal
@onready var cursor := $CursorPlaceholder/CursorIcon


func _ready():
	label.text = option_text
	ordinal_label.text = str(ordinal)
	if selected:
		cursor.show()
	else:
		cursor.hide()
