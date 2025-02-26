extends Button

@onready var deck: Node2D = %Deck
@onready var hand: Node2D = %Hand

func _on_pressed() -> void:
	# create new testing cards when button is pressed
	deck.generate_start_deck()
	hand.populate_hand_from_deck()
