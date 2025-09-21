extends Area3D

@onready var dialogue = preload("res://dialogues/radio.dialogue")

@onready var player = $"../../Player"

var repaired := false

func _ready() -> void:
	print("this is a test")
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if not repaired:
		_start_dialogue(dialogue, "start")
		

func _start_dialogue(dialogue: DialogueResource, start_node: String):
	player.can_move = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DialogueManager.show_dialogue_balloon(dialogue, start_node)
	await DialogueManager.dialogue_ended
	_on_dialogue_ended()

func _on_dialogue_ended():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	repaired = true
	player.can_move = true
