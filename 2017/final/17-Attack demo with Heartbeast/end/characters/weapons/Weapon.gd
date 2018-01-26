extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 1


func _ready():
	set_physics_process(false)


func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return

	for body in overlapping_bodies:
		if not body.is_in_group("character"):
			return
		if is_owner(body):
			return

		body.take_damage(damage)
	set_physics_process(false)


func is_owner(node):
	return node.weapon_path == get_path()


func _change_state(new_state):
	current_state = new_state

	# Initialize the new state
	match new_state:
		ATTACK:
			set_physics_process(true)
		IDLE:
			set_physics_process(false)


func attack():
	animation_player.play("attack")
	_change_state(ATTACK)


func _on_AnimationPlayer_animation_finished( name ):
	if name == "attack":
		_change_state(IDLE)
		emit_signal("attack_finished")
