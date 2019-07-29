extends Node
class_name State
"""
State interface for the Player scene.
Stores a reference to the Player and to the state machine.
As we're using Hierarchical State Machines, a state can be a node branch.
The lowest leaf tries to handle callbacks, and if it can't, it delegates the work to its parent.
"""


var is_composite: = get_child_count() != 0

var _state_machine: Node = null


func _ready() -> void:
	owner.connect("ready", self, "_setup")
	_state_machine = _get_state_machine(self)


func _setup() -> void:
	pass


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
