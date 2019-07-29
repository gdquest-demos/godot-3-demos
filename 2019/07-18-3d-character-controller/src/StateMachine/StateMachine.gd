extends Node
class_name StateMachine
"""
Hierarchical State machine for the player.
Initializes states and delegates engine callbacks (_physics_process, _unhandled_input) to the state.
"""

signal transitioned(transition)

export var initial_state: = NodePath()

onready var state: State = get_node(initial_state) setget set_state
onready var _state_name: = state.name


func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		return
	var target_state: = get_node(target_state_path)
	assert target_state.is_composite == false
	
	state.exit()
	self.state = target_state
	state.enter(msg)
	emit_signal("transitioned", target_state_path)


func set_state(value: State) -> void:
	state = value
	_state_name = state.name
