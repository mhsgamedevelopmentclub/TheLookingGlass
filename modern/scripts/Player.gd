extends KinematicBody2D
signal modern_hit

const GRAV_CONSTANT = 2000

onready var player_info := get_tree().root.get_node("/root/PlayerInfo")
onready var anim_player := $AnimatedSprite

export var jump_height := 960.0
export var max_speed := 640.0
export var acceleration := 0.08
export var deceleration := 0.08

var velo := Vector2()
var is_jumping := false
var jump_count := 0

func _ready():
	position = player_info.pos
	show()

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		velo.x = lerp(velo.x, max_speed, acceleration)
		if is_on_floor():
			anim_player.play("RunRight")
			anim_player.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velo.x = lerp(velo.x, -max_speed, acceleration)
		if is_on_floor():
			anim_player.play("RunRight")
			anim_player.flip_h = true
	else:
		velo.x = lerp(velo.x, 0, deceleration)
		if is_on_floor():
			anim_player.play("Still")
		
	if not is_on_floor():
		velo.y += delta * GRAV_CONSTANT

	# double jump feature
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		anim_player.play("Jump")
		velo.y = -jump_height
		is_jumping = true
		jump_count += 1

	if Input.is_action_just_released("jump") and is_jumping and jump_count == 2 and velo.y < -25:
		velo.y = -25
		is_jumping = false
	
	if is_on_ceiling() and is_jumping and velo.y < -25:
		velo.y = -25
		is_jumping = false
	
	if is_on_floor():
		jump_count = 0
	
	move_and_slide(velo, Vector2.UP)
	player_info.pos = position
	
	if is_on_floor():
		velo.y = 0
	
	# fall detection
	if position.y > 800:
		player_info.pos = player_info.last_checkpoint
		emit_signal("modern_hit")
	
	# Collision detection
	for collision in get_slide_count():
		var object := get_slide_collision(collision).collider
		if object.is_in_group("enemy"):
			hide()
			emit_signal("modern_hit")

	
