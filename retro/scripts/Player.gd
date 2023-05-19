extends KinematicBody2D
signal retro_hit
signal checkpoint_reached

const GRAV_CONSTANT := 400

onready var player_info := get_tree().root.get_node("/root/PlayerInfo")
onready var anim_player := $AnimatedSprite

export var jump_height := 200.0
export var max_speed := 120.0
export var acceleration := 0.06
export var deceleration := 0.06

var velo := Vector2()
var is_jumping := false
var jump_count := 0

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		velo.x = lerp(velo.x, max_speed, acceleration)
		if is_on_floor():
			anim_player.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velo.x = lerp(velo.x, -max_speed, acceleration)
		if is_on_floor():
			anim_player.flip_h = true
	else:
		velo.x = lerp(velo.x, 0, deceleration)
		
	if not is_on_floor():
		velo.y += delta * GRAV_CONSTANT

	# double jump feature
	if Input.is_action_just_pressed("jump") and jump_count < 1:
		velo.y = -jump_height
		is_jumping = true
		jump_count += 1

	if Input.is_action_just_released("jump") and is_jumping and jump_count == 1 and velo.y < -25:
		velo.y = -25
		is_jumping = false
	
	if is_on_ceiling() and is_jumping and velo.y < -25:
		velo.y = -25
		is_jumping = false
	
	if is_on_floor():
		jump_count = 0
	
	if velo.x != 0:
		anim_player.play()
	
	move_and_slide(velo, Vector2.UP)
	player_info.pos = position
	
	if is_on_floor():
		velo.y = 0
	
	# fall detection
	if position.y > 400:
		player_info.pos = player_info.last_checkpoint
		emit_signal("retro_hit")
	
	# Collision detection
	for collision in get_slide_count():
		var object := get_slide_collision(collision).collider
		if object.is_in_group("enemy"):
			emit_signal("retro_hit")
		elif object.is_in_group("checkpoint"):
			emit_signal("checkpoint_reached")
