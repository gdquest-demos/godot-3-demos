extends KinematicBody2D

var look_direction = Vector2(1, 0)

const MAX_WALK_SPEED = 450
const MAX_RUN_SPEED = 700

enum { IDLE, MOVE }
var state = null

func _ready():
	_change_state(IDLE)


func _change_state(new_state):
	match new_state:
		IDLE:
			$AnimationPlayer.play('idle')
		MOVE:
			$AnimationPlayer.play('walk')
	state = new_state


func _physics_process(delta):
	var input_direction = get_input_direction()
	update_look_direction(input_direction)

	if state == IDLE and input_direction:
		_change_state(MOVE)
	elif state == MOVE:
		if not input_direction:
			_change_state(IDLE)
			return
		var speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED
		move(speed, input_direction)


func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func update_look_direction(input_direction):
	if input_direction:
		look_direction = input_direction
	if not input_direction.x in [-1, 1]:
		return
	$BodyPivot.set_scale(Vector2(input_direction.x, 1))


func move(speed, direction):
	var velocity = direction.normalized() * speed
	move_and_slide(velocity, Vector2(), 5, 2)
