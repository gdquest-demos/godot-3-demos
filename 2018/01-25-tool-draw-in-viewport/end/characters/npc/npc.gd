tool
extends KinematicBody2D


const COLOR_WHITE = Color(1.0, 1.0, 1.0)

var max_speed = 0

var start_position = Vector2()
var end_position = Vector2()

var patrol_direction = Vector2()
var patrol_distance = 0.0

enum STATES_MIND { WAIT, MOVE }
var state = null
var previous_state = null

export(Vector2) var patrol_vector = Vector2(200, 120) setget _set_patrol_vector


func _ready():
	$Timer.connect('timeout', self, '_on_WaitTimer_timeout')

	# Disabling collisions
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
	if Engine.editor_hint:
		return

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
	if Engine.editor_hint:
		return

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


func _set_patrol_vector(value):
	patrol_vector = value
	end_position = start_position + patrol_vector
	update()


func _draw():
	if not Engine.editor_hint:
		return
	draw_line(Vector2(), patrol_vector, COLOR_WHITE, 4.0)
	
	draw_circle( patrol_vector, 12.0, COLOR_WHITE)
	draw_circle( patrol_vector, 10.0, Color('#fbc02d'))
