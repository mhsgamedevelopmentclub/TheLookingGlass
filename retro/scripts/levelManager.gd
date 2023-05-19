extends Node2D

onready var player_info := get_tree().root.get_node("/root/PlayerInfo")
onready var transition := $TransitionLayer

"""
	Main purpose of scene is to recieve signals
	from other game objects for level changing
	*DO NOT DEFINE LEVEL FUNCTIONS IN HERE*
"""

func swap_world():
	transition.transition_to("res://modern/scenes/ModernAlpha.tscn")

func update_checkpoint():
	player_info.last_checkpoint = player_info.pos
