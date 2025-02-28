extends CardState

var card_played: bool
var max_size_of_card_slot := 2

func enter() -> void:
	card_played = false # card not yet played

	var ui_layer := get_tree().get_nodes_in_group("ui_layer")

	if not card.targets.is_empty() and not ui_layer[2].get_child_count() < max_size_of_card_slot:
		# contains a valid target
		card_played = true # card played on a valid release spot
	else:
		card_played = false

func on_input(_event: InputEvent) -> void:
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")

	if not card_played:
		# reparent to "CardSlots" on release
		card.color.color = Color.DARK_MAGENTA
		card.reparent(ui_layer[2])
	else:
		# if card is not played or if CardSlot is full
		card.reparent(ui_layer[1])
		transition_requested.emit(self, CardState.State.BASE)
