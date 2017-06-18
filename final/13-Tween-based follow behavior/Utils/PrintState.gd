extends Label

onready var parent = get_parent()

var state_text = {}


func _ready():
	set_process(true)
	state_text[parent.IDLE] = "idle"
	state_text[parent.REST] = "rest"
	state_text[parent.PREPARE] = "prepare"
	state_text[parent.ATTACK] = "attack"

func _process(delta):
	set_text(str(state_text[parent.state]))
