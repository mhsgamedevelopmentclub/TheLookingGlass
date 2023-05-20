extends KinematicBody2D

onready var sprite := $Sprite

export var speed := 640
var motion = Vector2()
var gravity = 2000

var direction = -1 #  1 is equal to right and -1 is equal to left

func _physics_process(delta):
	motion.y += gravity
	motion.x += speed * direction
	if is_on_wall():
		direction = direction * -1
		
	motion = move_and_slide(motion)
