extends KinematicBody

"""
This is a simple first person controller
that moves the character in relation to
the direction the camera is pointing with
WASD and the left joystick.

I added the jump physics here as well, 
they seem to be too small for its own video
but I'd like feedback.
"""


export var move_speed:= 8.0
export var sensitivity:= 0.5
export var gravity:= 100.0
export var jump_force:= 30.0


var velocity:= Vector3.ZERO
var horizontal_move:= Vector3.ZERO


onready var camera:= $Camera


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	get_horizontal_input()
	motion(delta)


func get_horizontal_input()->void:
	horizontal_move = Vector3.ZERO
	horizontal_move += camera.global_transform.basis.x * (Input.get_action_strength("strafe_right") 
		- Input.get_action_strength("strafe_left"))
	horizontal_move += camera.global_transform.basis.z * (Input.get_action_strength("back") 
		- Input.get_action_strength("forward"))


func motion(delta: float)->void:
	var temp_velocity = Vector2(horizontal_move.x, horizontal_move.z).normalized() * move_speed
	
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.y
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
	else:
		velocity.y -= gravity * delta
		
	
	move_and_slide(velocity, Vector3.UP)
