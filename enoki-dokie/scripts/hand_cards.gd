class_name HandCards
extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		var child_card := child as Card
		child_card.reparent_requested.connect(_on_card_reparent_requested)

func _on_card_reparent_requested(child_card: Card) -> void:
	child_card.reparent(self)
