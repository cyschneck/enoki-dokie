extends Button

@onready var deck: Control = %Deck
@onready var hand: Control = %Hand

func _on_pressed() -> void:
	# create new testing cards when button is pressed
	deck.generate_start_deck()
	hand.populate_hand_from_deck()
