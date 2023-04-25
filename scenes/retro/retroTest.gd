extends Node2D

"""
	Main purpose of scene is to recieve signals
	from other game objects in the scene using
	the observer pattern.
	*DO NOT DEFINE LEVEL FUNCTIONS IN HERE*
"""

func _on_Player_retro_hit():
	get_tree().change_scene("res://scenes/modern/modernTest.tscn")
