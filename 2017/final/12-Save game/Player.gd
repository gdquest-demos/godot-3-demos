extends KinematicBody2D

var direction = Vector2()

var speed = 0
const MAX_SPEED = 400

var velocity = Vector2()
export(int) var max_health = 6


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if direction != Vector2():
		speed = MAX_SPEED
	else:
		speed = 0

	velocity = speed * direction.normalized() * delta

	move(velocity)


# The "save" method. It collects important data as a dictionary, and returns it to the Save node
func get_state():
	var save_dict = {
		pos={
			x=get_pos().x,
			y=get_pos().y
		},
		max_health=max_health
	}
	return save_dict


# JSON cannot store Vector2 values, so we have to reconstruct it manually. That's why for small games,
# the ConfigFile format is more convenient (it supports all of Godot's core data types)
# Refer to the previous tutorial/demo
func load_state(data):
	for attribute in data:
		if attribute == 'pos':
			set_pos(Vector2(data['pos']['x'], data['pos']['y']))
		else:
			set(attribute, data[attribute])
