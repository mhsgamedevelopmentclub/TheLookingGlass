extends KinematicBody2D

const GRAV_CONSTANT = 400

export var jump_height := 200.0
export var max_speed := 120.0
export var acceleration := 0.06
export var deceleration := 0.06

onready var animationPlayer = $AnimationPlayer

var velo := Vector2()
var is_jumping := false

func _physics_process(delta):
	animationPlayer.play("RunRight")
	if Input.is_action_pressed("move_right"):
		velo.x = lerp(velo.x, max_speed, acceleration)
		if is_on_floor():
			$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velo.x = lerp(velo.x, -max_speed, acceleration)
		if is_on_floor():
			$AnimatedSprite.flip_h = true
	else:
		velo.x = lerp(velo.x, 0, deceleration)
		
	if not is_on_floor():
		velo.y += delta * GRAV_CONSTANT

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velo.y = -jump_height
		is_jumping = true
	if Input.is_action_just_released("jump") and is_jumping and velo.y < -25:
		velo.y = -25
		is_jumping = false
	
	if velo.x != 0:
		$AnimatedSprite.play()
	
	move_and_slide(velo, Vector2.UP)
