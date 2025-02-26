extends Node2D

@onready var card_manager: Node2D = %CardManager
@onready var deck: Node2D = %Deck

@onready var CARD_PREFAB: PackedScene = preload("res://scenes/card.tscn")

var cards_in_deck: Array = ["death cap", 
							"mica cap", 
							"birch polypore", 
							"jack o'lantern",
							"velvet foot"]

func _ready() -> void:
	# clear temporary cards
	for card in deck.get_children():
		card.queue_free()

func generate_start_deck() -> void:
	for card_name in cards_in_deck:
		var json_data_dict = card_manager.get_mushroom_data()[card_name]
		var mushroom_card = CARD_PREFAB.instantiate()
		mushroom_card.set_card_characteristics(card_name, mushroom_card, json_data_dict)
		mushroom_card.scale = Vector2(0.6, 0.6)
		deck.add_child(mushroom_card)
