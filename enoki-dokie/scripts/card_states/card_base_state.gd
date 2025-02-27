extends CardState

func enter() -> void:
	# wait until node is ready
	if not card.is_node_ready():
		await card.ready
	card.reparent_requested.emit(card)
	card.color.color = Color.WEB_GREEN
	card.state = "BASE"
	card.pivot_offset = Vector2(0,0)

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card.pivot_offset = card.get_global_mouse_position() - card.global_position # drags card from position selected
		# transition to CLICKED state
		transition_requested.emit(self, CardState.State.CLICKED)
