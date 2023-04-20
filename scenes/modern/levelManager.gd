extends Node2D

"""
	Main purpose of scene is to recieve signals
	from other game objects for level changing
	*DO NOT DEFINE LEVEL FUNCTIONS IN HERE*
"""

func swap_world():
	get_tree().change_scene("res://scenes/retro/retroTestAlpha.tscn")

func level_complete():
	pass

