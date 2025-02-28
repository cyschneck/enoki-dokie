extends CardState

# min time to stay in drag time
const DRAG_MIN_THRESHOLD := 0.05
var min_drag_time_elapsed := false

func enter() -> void:
	# remove from hand while dragging
	# reparent to "Card Manager" on dragging
	var ui_layer := get_tree().get_nodes_in_group("ui_layer")
	card.reparent(ui_layer[0])

	card.scale = Vector2(1, 1)
	card.color.color = Color.NAVY_BLUE

	# set min time to stay in dragging state
	min_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MIN_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): min_drag_time_elapsed = true)

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
	if confirm and min_drag_time_elapsed:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		
	
