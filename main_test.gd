@tool
#extends Node
extends Node3D
@onready var dialogue = preload("res://dialogues/intro.dialogue")
@onready var label = $DialoguePanel/DialogueLabel


func _ready():
	if not Engine.is_editor_hint() and has_node("UI"):
		$UI.player = $Player
		$UI.terrain = $Terrain3D
		DialogueManager.connect("line_started", Callable(self, "_on_dialogue_line_started"))
		DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_ended"))
		_start_dialogue(dialogue, "start")
		
		
func _start_dialogue(dialogue: DialogueResource, start_node: String):
	$Player.can_move = false
	DialogueManager.show_dialogue_balloon(dialogue, start_node)
	await DialogueManager.dialogue_ended
	_on_dialogue_ended()

func _on_dialogue_ended():
	$Player.can_move = true
