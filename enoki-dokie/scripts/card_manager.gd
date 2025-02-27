extends Control

var cards: Dictionary

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
###
'''
func _process(_delta: float) -> void:
	if card_being_dragged:
		var mouse_position = get_viewport().get_mouse_position()
		card_being_dragged.global_position = mouse_position

## CARD INTERACTION
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# prsesed
			var card = raycast_check_for_card()
			if card:
				card_dragging(card)
		else:
			# released
			if card_being_dragged:
				card_release()

func card_dragging(card):
	card_being_dragged = card
	card.scale = Vector2(1, 1)

func card_release():
	card_being_dragged.scale = Vector2(0.6, 0.6)
	card_being_dragged = null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	print(result)
	if result:
		# only drag "cards" in the "hand"
		if "CardArea2D" in str(result[0].collider) and result[0].collider.get_parent().get_parent() == hand:
			return result[0].collider.get_parent() # returns specific card
	return null
'''
