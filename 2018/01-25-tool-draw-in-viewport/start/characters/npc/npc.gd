extends KinematicBody2D


export(Vector2) var patrol_vector = Vector2(200, 120)

var max_speed = 0

var start_position = Vector2()
var end_position = Vector2()

var patrol_direction = Vector2()
var patrol_distance = 0.0

enum STATES_MIND { WAIT, MOVE }
var state = null
var previous_state = null


func _ready():
	$Timer.connect('timeout', self, '_on_WaitTimer_timeout')
	$CollisionShape2D.disabled = true

	max_speed = 240
	start_position = position
	end_position = start_position + patrol_vector

	patrol_direction = patrol_vector.normalized()
	patrol_distance = patrol_vector.length()

	_change_state(WAIT)

	randomize()
	$Timer.wait_time = randf() * 2
	$Timer.start()


func _physics_process(delta):
	if not state == MOVE:
		return

	var move_distance = max_speed * delta
	var motion = move_distance * patrol_direction

	patrol_distance -= move_distance
	position += motion

	if patrol_distance < 0.0:
		patrol_direction *= -1
		patrol_distance = patrol_vector.length()
		_change_state(WAIT)


func _change_state(new_state):
	match new_state:
		WAIT:
			$AnimationPlayer.play('idle')
			$Timer.wait_time = 1.0
			$Timer.start()
		MOVE:
			$AnimationPlayer.play('walk')
			$Timer.stop()
	state = new_state


func _on_WaitTimer_timeout():
	_change_state(MOVE)
