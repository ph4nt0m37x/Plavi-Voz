extends Area3D

@onready var dialogue = preload("res://dialogues/radiation.dialogue")
@onready var player = $"../../../Player"

var warning = true

func _on_body_entered(body):
	if warning:
		warning = false
		_start_dialogue(dialogue, "start")

func _start_dialogue(dialogue: DialogueResource, start_node: String):
	player.can_move = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DialogueManager.show_dialogue_balloon(dialogue, start_node)
	await DialogueManager.dialogue_ended
	_on_dialogue_ended()

func _on_dialogue_ended():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.can_move = true
