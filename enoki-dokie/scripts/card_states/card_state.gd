class_name CardState
extends Node

var card: Card
enum State {BASE, CLICKED, DRAGGING, RELEASED}
@export var state: State

signal transition_requested(from: CardState, to: State)

func enter() -> void:
	pass

func exit() -> void:
	pass

func on_input(_event: InputEvent) -> void:
	pass

func on_gui_input(_event: InputEvent) -> void:
	pass

func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass
