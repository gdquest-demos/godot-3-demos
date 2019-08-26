extends KinematicBody

"""
This is a simple first person controller
that moves the character in relation to
the direction the camera is pointing with
WASD and the left joystick.

I added the jump physics here as well, 
they seem to be too small for its own video
but I'd like feedback.

I added two different functions for the camera.
The joypad version works pretty well, but the
mouse one makes me nauseous.  That's why I 
added the debug labels and the reticle.

I added a raycast as a child of the camera, 
made a sprite3d for a decal when hitting something
and a shoot method to tell the scene to make a 
decal at a specific spot.  The player part seems
to be working okay, but the decal is being created 
a bit wonky.

Feedback is appreciated.
"""


export var move_speed:= 8.0
export var sensitivity:= 0.001
export var joypad_rotation_speed:= 60.0
export var gravity:= 100.0
export var jump_force:= 30.0
export var hit_decal: PackedScene


var velocity:= Vector3.ZERO
var horizontal_move:= Vector3.ZERO


onready var camera:= $Camera
onready var ray:= $Camera/RayCast
onready var sound:= $AudioStreamPlayer3D

signal cam_x
signal cam_y
signal shot_fired


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	get_horizontal_input()
	joypad_camera_rotation(delta)
	motion(delta)
	debug_labels()


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(event.relative.y * sensitivity)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -45, 45)
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("fire") and ray.is_colliding():
		shoot()
	


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


func joypad_camera_rotation(delta: float)->void:
	rotation_degrees.y += (Input.get_action_strength("camera_left") - 
		Input.get_action_strength("camera_right")) * joypad_rotation_speed * delta
	camera.rotation_degrees.x += (Input.get_action_strength("camera_up") - 
		Input.get_action_strength("camera_down")) * joypad_rotation_speed * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -45, 45)


func shoot()->void:
	camera.screen_kick(2.5, 0.3)
	emit_signal("shot_fired", ray.get_collision_point(), ray.get_collision_normal())
	sound.play()


func debug_labels()->void:
	emit_signal("cam_x", camera.rotation_degrees.x)
	emit_signal("cam_y", rotation_degrees.y)


