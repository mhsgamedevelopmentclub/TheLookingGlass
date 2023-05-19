extends Button

onready var transition_layer := get_tree().root.get_node('/root/global/TransitionLayer.tscn')

func _on_Button_pressed():
	transition_layer.transition_to('res://retro/scenes/RetroAlphaLevel1.tscn')
