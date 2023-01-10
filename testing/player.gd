extends KinematicBody2D

const GRAV_CONSTANT = 19.6

export var init_speed := 10.0
export var max_speed := 60.0

var velo = Vector2()

func _physics_process(delta):
	velo.y += delta * GRAV_CONSTANT
	
	if Input.is_action_pressed("move_right"):
		velo.x = max_speed
	elif Input.is_action_pressed("move_left"):
		velo.x = -max_speed
	else:
		velo.x = 0
	
	move_and_slide(velo)
