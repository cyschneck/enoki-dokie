extends CardState

func enter() -> void:
	# remove from hand while dragging
	# reparent to "Card Manager" on dragging
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")
	card.reparent(ui_layer[0])
	
	card.color.color = Color.NAVY_BLUE

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion # true when mouse is moving
	var cancel = event.is_action_pressed("right_mouse") # cancel movement with right click
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse") # confirm by releasing left mouse
	
	if mouse_motion:
		# update global position of card while dragging
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	if cancel:
		# if dragging is canceled, return to base state
		# on cancel, reparent to HandCards
		var ui_layer := get_tree().get_nodes_in_group("ui_layer")
		card.reparent(ui_layer[1])
		transition_requested.emit(self, CardState.State.BASE)
	if confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		
	
