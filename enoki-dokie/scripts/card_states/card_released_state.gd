extends CardState

func enter() -> void:
	# reparent to "CardSlots" on release
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")
	card.reparent(ui_layer[2])

	card.color.color = Color.DARK_VIOLET
