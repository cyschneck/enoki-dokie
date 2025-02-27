extends CardState

func enter() -> void:
	# remove from hand
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer)
	
	card.color.color = Color.NAVY_BLUE
	card.state = "DRAGGING"

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion # true when mouse is moving
	var cancel = event.is_action_pressed("right_mouse") # cancel movement with right click
	var confirm = event.is_action_pressed("left_mouse") or event.is_action_pressed("left_mouse") # confirm by releasing left mouse
	
	if mouse_motion:
		# update global position of card while dragging
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	if cancel:
		# if dragging is canceled, return to base state
		transition_requested.emit(self, CardState.State.BASE)
	if confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		
	
