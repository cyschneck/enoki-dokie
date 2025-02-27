extends Control

@onready var hand: Control = %Hand
@onready var deck: Control = %Deck

@export var hand_size = 4

func _ready() -> void:
	# clear temporary cards
	for card in hand.get_child(0).get_children():
		card.queue_free()

func populate_hand_from_deck() -> void:
	var i = 0
	for card in deck.get_children():
		# move cards from deck to hand
		if i < hand_size:
			i += 1
			deck.remove_child(card)
			hand.get_child(0).add_child(card)
