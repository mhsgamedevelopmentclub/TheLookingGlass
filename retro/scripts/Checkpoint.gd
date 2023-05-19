extends Area2D

onready var player_info := get_tree().root.get_node("/root/PlayerInfo")
onready var anim_sprite := $AnimatedSprite

func _ready():
	anim_sprite.frame = 0

func _on_Checkpoint_body_entered(body):
	anim_sprite.frame = 1
	if body.name == "Player":
		player_info.last_checkpoint = position
