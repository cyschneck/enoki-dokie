extends CardState

func enter() -> void:
	card.color.color = Color.ORANGE
	# enable monitoring to find drop point when first clicked
	card.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# if mouse is in movement, transition to DRAGGING
		transition_requested.emit(self, CardState.State.DRAGGING)
