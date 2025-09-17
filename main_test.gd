@tool
#extends Node
extends Node3D

func _ready():
	if not Engine.is_editor_hint() and has_node("UI"):
		$UI.player = $Player
		$UI.terrain = $Terrain3D
