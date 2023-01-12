extends KinematicBody2D

const GRAV_CONSTANT = 400

export var jump_height := 200.0
export var max_speed := 120.0
export var acceleration := 0.04
export var deceleration := 0.04

var velo = Vector2()

func _physics_process(delta):
	if !is_on_floor():
		velo.y += delta * GRAV_CONSTANT
	
	if Input.is_action_pressed("move_right"):
		velo.x = lerp(velo.x, max_speed, acceleration)
	elif Input.is_action_pressed("move_left"):
		velo.x = lerp(velo.x, -max_speed, acceleration)
	else:
		velo.x = lerp(velo.x, 0, deceleration)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		var start = OS.get_ticks_msec()
		if Input.is_action_just_released("jump"):
			var end = OS.get_ticks_msec() - start
			velo.y = -(jump_height * end * 100)
	
	move_and_slide(velo, Vector2.UP)
