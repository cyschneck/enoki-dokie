extends Button

@onready var card_manager: Node = %CardManager
@onready var CARD_PREFAB: PackedScene = preload("res://scenes/card.tscn")

func _ready() -> void:
	# clear temporary cards
	for card in card_manager.get_children():
		card.queue_free()

func _on_pressed() -> void:
	# create new testing cards when button is pressed
	var cards_to_make = ["death cap", 
						"mica cap", 
						"birch polypore", 
						"jack o'lantern",
						"velvet foot"
						]
	for card_name in cards_to_make:
		var mushroom_card = CARD_PREFAB.instantiate()
		var json_data_dict = card_manager.cards[card_name]
		mushroom_card.set_card_characteristics(card_name, mushroom_card, json_data_dict)
		card_manager.add_child(mushroom_card)
