extends "state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"stagger": $Stagger,
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["stagger"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

func _input(event):
	current_state.handle_input(event)
