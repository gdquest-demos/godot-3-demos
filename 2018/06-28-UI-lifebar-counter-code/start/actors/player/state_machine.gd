extends Node

signal state_changed(current_state)

export(NodePath) var START_STATE_PATH
var states_map = {}

var states_stack = []
var current_state = null
var _active = false setget set_active

func _ready():
	for child in get_children():
		child.connect("finished", self, "_change_state")
	initialize(START_STATE_PATH)

func initialize(start_state_path):
	set_active(true)
	var start_state
	if start_state_path:
		start_state = get_node(start_state_path)
	else:
		start_state = get_child(0)
	states_stack.push_front(start_state)
	current_state = states_stack[0]
	current_state.enter()

func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null

func _input(event):
	current_state.handle_input(event)

func _physics_process(delta):
	current_state.update(delta)

func _on_animation_finished(anim_name):
	if not _active:
		return
	current_state._on_animation_finished(anim_name)

func _change_state(state_name):
	if not _active:
		return
	current_state.exit()
	
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
	
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	
	if state_name != "previous":
		current_state.enter()
