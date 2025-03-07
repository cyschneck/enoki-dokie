extends Control

var cards: Dictionary = {}

const MUSHROOM_JSON_DATA = "res://data/mushroom_data.json"
@onready var hand: Control = %Hand

var card_being_dragged

func _ready() -> void:
	load_json_data(MUSHROOM_JSON_DATA)

### LOAD JSON DATA
func load_json_data(file_path: String):
	var data_file = FileAccess.open(file_path, FileAccess.READ)
	var results = JSON.parse_string(data_file.get_as_text())
	cards = results

func get_mushroom_data():
	return cards
