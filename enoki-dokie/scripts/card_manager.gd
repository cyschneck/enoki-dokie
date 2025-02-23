extends Node

var cards: Dictionary

const MUSHROOM_JSON_DATA = "res://data/mushroom_data.json"

func _ready() -> void:
	load_json_data(MUSHROOM_JSON_DATA)
	
func load_json_data(file_path: String):
	var data_file = FileAccess.open(file_path, FileAccess.READ)
	var results = JSON.parse_string(data_file.get_as_text())
	cards = results
