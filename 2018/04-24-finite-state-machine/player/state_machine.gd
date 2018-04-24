"""
The point of the State pattern is to separate concerns, to help follow
the single responsibility principle. Each state describes an action or 
behavior.

The state machine is the only entity that's aware of the states. 
That's why this script receives strings from the states: it maps 
these strings to actual state objects: the states (Move, Jump, etc.)
are not aware of their siblings. This way you can change any of 
the states anytime without breaking the game.
"""
extends KinematicBody2D

signal state_changed

var look_direction = Vector2(1, 0)

"""
This example keeps a history of some states so e.g. after taking a hit,
the character can return to the previous state. The states_stack is 
an Array, and we use Array.push_front() and Array.pop_front() to add and
remove states from the history.
"""
var states_stack = []
var current_state = null

onready var states_map = {
	'idle': $States/Idle,
	'move': $States/Move,
	'jump': $States/Jump,
	'stagger': $States/Stagger,
}

func _ready():
	states_stack.push_front($States/Idle)
	current_state = states_stack[0]
	_change_state('idle')


# The state machine delegates process and input callbacks to the current state
# The state object, e.g. Move, then handles input, calculates velocity 
# and moves what I called its "host", the Player node (KinematicBody2D) in this case.
func _physics_process(delta):
	var state_name = current_state.update(self, delta)
	if state_name:
		_change_state(state_name)


func _input(event):
	"""
	If you make a shooter game, you may want the player to be able to
	fire bullets anytime.
	If that's the case you don't want to use the states. They'll add micro
	freezes in the gameplay and/or make your code more complex
	Firing is the weapon's responsibility (BulletSpawn here) so the weapon should handle it
	"""
	if event.is_action_pressed('fire'):
		$BulletSpawn.fire(look_direction)
		return
	var state_name = current_state.handle_input(self, event)
	if state_name:
		_change_state(state_name)


func _on_animation_finished(anim_name):
	"""
	We want to delegate every method or callback that could trigger 
	a state change to the state objects. The base script state.gd,
	that all states extend, makes sure that all states have the same
	interface, that is to say access to the same base methods, including
	_on_animation_finished. See state.gd
	"""
	var state_name = current_state._on_animation_finished(anim_name)
	if state_name:
		_change_state(state_name)


func _change_state(state_name):
	"""
	We use this method to:
		1. Clean up the current state with its the exit method
		2. Manage the flow and the history of states
		3. Initialize the new state with its enter method
	Note that to go back to the previous state in the states history,
	the state objects return the 'previous' keyword and not a specific
	state name.
	"""
	current_state.exit(self)

	if state_name == 'previous':
		states_stack.pop_front()
	elif state_name in ['stagger', 'jump']:
		states_stack.push_front(states_map[state_name])
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state

	if state_name == 'jump':
		$States/Jump.initialize(current_state.speed, current_state.velocity)

	current_state = states_stack[0]
	if state_name != 'previous':
		# We don't want to reinitialize the state if we're going back to the previous state
		current_state.enter(self)
	emit_signal('state_changed', states_stack)
