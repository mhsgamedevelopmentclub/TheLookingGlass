extends Button

onready var transition_layer := $'../TransitionLayer'

func _on_Button_pressed():
	transition_layer.transition_to('res://retro/scenes/RetroAlphaLevel1.tscn')
