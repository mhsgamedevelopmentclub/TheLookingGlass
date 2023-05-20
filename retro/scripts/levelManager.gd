extends Node2D

onready var transition_layer := $'CanvasLayer/TransitionLayer'

"""
	Main purpose of scene is to recieve signals
	from other game objects for level changing
	*DO NOT DEFINE LEVEL FUNCTIONS IN HERE*
"""

func swap_world():
	transition_layer.transition_to("res://modern/scenes/Level1.tscn")
