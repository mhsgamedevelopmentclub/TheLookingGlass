extends KinematicBody2D
signal modern_hit

const GRAV_CONSTANT := 400

export var jump_height := 200.0
export var max_speed := 120.0
export var acceleration := 0.04
export var deceleration := 0.08

var velo = Vector2()
var is_jumping := false
var was_grounded := true
var jump_count := 0

func _physics_process(delta):
	# Check for scene transition (TEST):
	if Input.is_action_just_pressed("(test)_change_scene"):
		emit_signal("modern_hit")
	
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
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and not is_jumping and jump_count < 1:
			velo.y = -jump_height
			is_jumping = true
			jump_count += 1
		if not $CoyoteTime.is_stopped() and not is_jumping:
			velo.y = -jump_height
			jump_count += 1
			$CoyoteTime.stop()
	
	if Input.is_action_just_released("jump") and is_jumping and jump_count == 1 and velo.y < -50:
		velo.y = -50
		is_jumping = false
	
	if is_on_ceiling() and is_jumping and velo.y < -50:
		velo.y = -50
	
	if velo.x != 0:
		$AnimatedSprite.play()
		
	was_grounded = is_on_floor()
	move_and_slide(velo, Vector2.UP)
	if was_grounded and not is_on_floor() and not is_jumping:
		$CoyoteTime.start()
	
	if is_on_floor():
		velo.y = 0
		
	# Collision detection
	if velo.y < 400:
		# set player position to last checkpoint
		emit_signal("modern_hit")
	
	
