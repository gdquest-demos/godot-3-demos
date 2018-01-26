extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 1


func _ready():
	set_physics_process(false)


func attack():
	# Called from the character, when it switches to the ATTACK state
	pass


func _change_state(new_state):
	current_state = new_state
	# Initialize the new state


func _physics_process(delta):
	# Get colliding bodies

	# For each body, check if it's an enemy
	# If so, damage it and stop physics process for this attack
	# Otherwise it damages targets on every tick
	pass


func is_owner(node):
	# Return true if the node is the weapon's owner
	pass


# Write AnimationPlayer callback when the attack animation ends
