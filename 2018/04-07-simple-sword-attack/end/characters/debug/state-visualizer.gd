extends Label

const STATE_STRINGS = [
  "spawn",
  "idle",
  "move",
  "jump",
  "bump",
  "fall"
]


func _ready():
	$'..'.connect('state_changed', self, '_on_Player_state_changed')


func _on_Player_state_changed(new_state):
	text = STATE_STRINGS[new_state]