extends KinematicBody
class_name Player

export var move_speed : = 10.0
export var rotate_speed : = 3.0 
export var jump_force : = 50.0

func _physics_process(delta : float) -> void:
	var z_movement = int(Input.is_action_pressed("backward")) - int(Input.is_action_pressed("forward"))
	var rotate = int(Input.is_action_pressed("left")) - int(Input.is_action_pressed("right"))
	
	rotation.y += rotate * rotate_speed * delta
	
	move_and_collide(Vector3(0, 0, 1).rotated(Vector3(0, 1, 0), rotation.y) * z_movement * delta * move_speed)
