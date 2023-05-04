extends Area2D

onready var player_info

func _ready():
	player_info = get_tree().root.get_node("/root/PlayerInfo")

func _on_Checkpoint_body_entered(body):
	if body.name == "Player":
		# Invoke transfer from modern -> retro
		pass
