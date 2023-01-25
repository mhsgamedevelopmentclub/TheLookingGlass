extends KinematicBody2D

const GRAV_CONSTANT := 400

export var jump_height := 200.0
export var max_speed := 120.0
export var acceleration := 0.06
export var deceleration := 0.06

var velo = Vector2()
var is_jumping := false
var was_grounded := true

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		velo.x = lerp(velo.x, max_speed, acceleration)
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velo.x = lerp(velo.x, -max_speed, acceleration)
		$AnimatedSprite.flip_h = true
	else:
		velo.x = lerp(velo.x, 0, deceleration)
	
	if not is_on_floor():
		velo.y += delta * GRAV_CONSTANT
		if was_grounded:
			$CoyoteTime.start()
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velo.y = -jump_height
			is_jumping = true
		if not $CoyoteTime.is_stopped():
			velo.y = -jump_height
			$CoyoteTime.stop()

	if Input.is_action_just_released("jump") and is_jumping and velo.y < -25:
		velo.y = -25
		is_jumping = false
	
	if velo.x != 0:
		$AnimatedSprite.play()
		
	was_grounded = is_on_floor()
	move_and_slide(velo, Vector2.UP)
	if was_grounded and not is_on_floor() and not is_jumping:
		$CoyoteTime.start()
