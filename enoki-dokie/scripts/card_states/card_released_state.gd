extends CardState

func enter() -> void:
	card.color.color = Color.DARK_VIOLET
	card.state = "RELEASED"
