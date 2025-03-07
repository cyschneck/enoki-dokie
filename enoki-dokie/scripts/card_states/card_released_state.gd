extends CardState

var max_size_of_card_slot := 2
var valid_card_played: bool

func enter() -> void:
	valid_card_played = false # card not yet played

	var ui_layer := get_tree().get_nodes_in_group("ui_layer")

	# contains a valid target
	if not card.targets.is_empty() and ui_layer[2].get_child_count() < max_size_of_card_slot:
		valid_card_played = true # card played on a valid release spot
	else:
		valid_card_played = false

func on_input(_event: InputEvent) -> void:
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")

	if valid_card_played:
		# valid placement for card
		card.color.color = Color.DARK_MAGENTA
		# reparent to "CardSlots" on release
		card.reparent(ui_layer[2])
	else:
		# invalid placement for card
		# if card is not played or if CardSlot is full
		# reparent to HAND
		card.reparent(ui_layer[1])
		transition_requested.emit(self, CardState.State.BASE)
