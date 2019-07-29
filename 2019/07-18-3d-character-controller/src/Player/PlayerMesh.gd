extends Spatial

onready var animation_tree : AnimationTree = $Rig/AnimationTree

var _state_machine


func _ready() -> void:
	animation_tree.active = true
	_state_machine = animation_tree["parameters/playback"]


func _travel(transition: String) -> void:
	var state: = transition.split("/")[1].to_lower()
	match state:
		"idle":
			_state_machine.travel("idle")
		"run":
			_state_machine.travel("run")
		"air":
			_state_machine.travel("jump")


func _on_StateMachine_transitioned(transition) -> void:
	_travel(transition)
