extends Node

@export var textbox_open := false  # decides whether to use textbox input or player input

var eventbus := Eventbus

var interactions = {
	"tv-from-left":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-from-right":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-from-up":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-from-down":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	}
}


func _ready():
	eventbus.connect("textbox_hidden", on_textbox_closed)


func open_textbox(interaction_key: String) -> void:
	textbox_open = true
	eventbus.show_textbox.emit(interactions[interaction_key])


func on_textbox_closed() -> void:
	textbox_open = false
