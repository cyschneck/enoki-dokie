extends Button

@onready var card_manager: Node = %CardManager
@onready var CardScene: PackedScene = preload("res://scenes/card.tscn")

func _on_pressed() -> void:
	print(card_manager.cards)
