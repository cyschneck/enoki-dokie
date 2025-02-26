extends Node2D

@onready var hand: Node2D = %Hand
@onready var deck: Node2D = %Deck

func _ready() -> void:
	# clear temporary cards
	for card in hand.get_children():
		card.queue_free()

func populate_hand_from_deck() -> void:
	var hand_size: int = 3
	
	var i = 0
	for card in deck.get_children():
		# move cards from deck to hand
		if i < hand_size:
			i += 1
			deck.remove_child(card)
			hand.add_child(card)
