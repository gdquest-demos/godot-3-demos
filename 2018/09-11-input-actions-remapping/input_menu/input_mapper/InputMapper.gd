extends Node

signal profile_changed(new_profile, is_customizable)

var current_profile_id = 0
var profiles = {
	0: 'profile_normal',
	1: 'profile_alternate',
	2: 'profile_custom',
}
var profile_normal = {
	'move_up': KEY_UP,
	'move_down': KEY_DOWN,
	'move_left': KEY_LEFT,
	'move_right': KEY_RIGHT
}
var profile_alternate = {
	'move_up': KEY_W,
	'move_down': KEY_S,
	'move_left': KEY_A,
	'move_right': KEY_D
}
var profile_custom = profile_normal

func change_profile(id):
	current_profile_id = id
	var profile = get(profiles[id])
	var is_customizable = true if id == 2 else false
	
	for action_name in profile.keys():
		change_action_key(action_name, profile[action_name])
	emit_signal('profile_changed', profile, is_customizable)
	return profile

func change_action_key(action_name, key_scancode):
	erase_action_events(action_name)

	var new_event = InputEventKey.new()
	new_event.set_scancode(key_scancode)
	InputMap.action_add_event(action_name, new_event)
	get_selected_profile()[action_name] = key_scancode

func erase_action_events(action_name):
	var input_events = InputMap.get_action_list(action_name)
	for event in input_events:
		InputMap.action_erase_event(action_name, event)

func get_selected_profile():
	return get(profiles[current_profile_id])

func _on_ProfilesMenu_item_selected(ID):
	change_profile(ID)
