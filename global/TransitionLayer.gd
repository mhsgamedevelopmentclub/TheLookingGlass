extends ColorRect

onready var anim_player := $AnimationPlayer

func _ready():
	anim_player.play_backwards("Fade")

func transition_to(scene):
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	get_tree().change_scene(scene)
