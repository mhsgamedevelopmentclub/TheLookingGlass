extends Node2D

"""
	Main purpose of scene is to recieve signals
	from other game objects for level changing
	*DO NOT DEFINE LEVEL FUNCTIONS IN HERE*
"""

func game_over():
	get_tree().quit()
