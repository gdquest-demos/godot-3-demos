extends Node

var debug = false
onready var MovementVisualizer = get_node("Car/MovementVisualizer")

func _ready():
	set_process_input(true)
	set_pause_mode(PAUSE_MODE_PROCESS)

func _input(event):
	var pause_pressed = event.is_action_pressed("pause")
	var debug_pressed = event.is_action_pressed("debug")
	if pause_pressed:
		if get_tree().is_paused():
			get_tree().set_pause(false)
		else:
			get_tree().set_pause(true)
	if debug_pressed:
		debug = not debug
		if debug:
			MovementVisualizer.set("visibility/visible", false)
		else:
			MovementVisualizer.set("visibility/visible", true)
		


