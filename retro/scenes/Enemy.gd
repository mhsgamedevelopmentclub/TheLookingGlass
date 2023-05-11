extends KinematicBody2D

var speed = 120
var motion = Vector2()
var gravity = 20

var direction = 1 #  1 is equal to right and -1 is equal to left

func _physics_process(delta):
	motion.y += gravity
	motion.x += speed * direction
	if is_on_wall():
		direction = direction * -1
		
	motion = move_and_slide(motion)


#this code can be used later to make the enemy follow the player possibly. Needs a player node access to work

#export var speed = 100
#var player_position
#var taget_position
#onready var player = get_node("retro/scenes/")

#func _physics_process(delta):
	#player_position = player.get_position_in_parent()
	#taget_position = (player_position - position).normalized()
	
	#if position.distance_to(player_position) > 3:
		#move_and_slide(taget_position * speed)
		#look_at(player_position)
