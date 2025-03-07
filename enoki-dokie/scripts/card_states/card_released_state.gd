extends CardState

var max_size_of_card_slot := 2
var valid_card_played_slot_1: bool
var valid_card_played_slot_2: bool

func enter() -> void:
	valid_card_played_slot_1 = false # card not yet played in slot 1
	valid_card_played_slot_2 = false # card not yet played in slot 2

	var ui_layer := get_tree().get_nodes_in_group("ui_layer")

	# contains a valid target
	if not card.targets.is_empty():
		if card.targets[0].name == "CardDropArea1":
			if ui_layer[2].get_child_count() < max_size_of_card_slot:
				valid_card_played_slot_1 = true # card played on a valid release spot
		if card.targets[0].name == "CardDropArea2":
			if ui_layer[3].get_child_count() < max_size_of_card_slot:
				valid_card_played_slot_2 = true # card played on a valid release spot

func on_input(_event: InputEvent) -> void:
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")

	#  ui_layer[2] = CardSlot1
	#  ui_layer[3] = CardSlot2
	if valid_card_played_slot_1 or valid_card_played_slot_2:
		# valid placement for card
		card.color.color = Color.DARK_MAGENTA
		if valid_card_played_slot_1:
			# reparent to "CardSlots1" on release
			card.reparent(ui_layer[2])
		if valid_card_played_slot_2:
			# reparent to "CardSlots1" on release
			card.reparent(ui_layer[3])
	else:
		# invalid placement for card
		# if card is not played or if CardSlot is full
		# reparent to HAND
		card.reparent(ui_layer[1])
		transition_requested.emit(self, CardState.State.BASE)
