extends Area2D

var nearby := false
onready var text := $Text

func _ready():
	text.hide()

func _process(delta):
	if Input.is_action_just_pressed("(test)_view_sign") and nearby:
		text.show()

func _on_Sign_body_entered(body):
	nearby = true

func _on_Sign_body_exited(body):
	nearby = false
	text.hide()
