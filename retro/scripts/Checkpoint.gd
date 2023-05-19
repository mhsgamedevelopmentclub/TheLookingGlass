extends Area2D

onready var player_info := get_tree().root.get_node("/root/PlayerInfo")

func _on_Checkpoint_body_entered(body):
	if body.name == "Player":
		player_info.last_checkpoint = position
