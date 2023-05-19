extends Node2D

onready var player_info := get_tree().root.get_node("/root/PlayerInfo")
onready var transition_layer := $TransitionLayer

"""
	Main purpose of scene is to recieve signals
	from other game objects for level changing
	*DO NOT DEFINE LEVEL FUNCTIONS IN HERE*
"""

func swap_world():
	transition_layer.transition_to("res://retro/scenes/RetroAlpha.tscn")

func update_checkpoint():
	pass
