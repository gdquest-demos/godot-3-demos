extends Label

onready var Character = $'..'

func _ready():
	visible = false

func _physics_process(delta):
	text = str(Character.current_state)