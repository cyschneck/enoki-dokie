extends CardState

var card_played: bool

func enter() -> void:
	card_played = false # card not yet played

	if not card.targets.is_empty():
		# contains a valid target
		card.color.color = Color.DARK_MAGENTA
		card_played = true # card played on a valid release spot

		# reparent to "CardSlots" on release
		var ui_layer := get_tree().get_nodes_in_group("ui_layer")
		card.reparent(ui_layer[2])

func on_input(_event: InputEvent) -> void:
	if card_played:
		return
	
	# if card is not played
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")
	card.reparent(ui_layer[1])
	transition_requested.emit(self, CardState.State.BASE)
