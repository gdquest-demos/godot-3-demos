extends StaticBody2D


"""
A simple turret.  It rotates at a rate of 45 degrees per second.  
When the raycast collides with the player it generates a shot and
points the shot towards the player

"""


export var rotation_speed: = 100
export var turret_shot: PackedScene


var colliding:= false
var hit_point:= Vector2.ZERO
var can_shoot:= true


onready var pointer:= $Pointer
onready var ray:= $Pointer/RayCast2D
onready var shot_timer:= $ShotDelay


func _process(delta):
	pointer.rotation_degrees += rotation_speed * delta
	shoot()


func shoot()->void:
	if can_shoot and ray.is_colliding():
		if ray.get_collider().is_in_group("Player"):
			can_shoot = false
			var temp = turret_shot.instance()
			add_child(temp)
			temp.global_position = global_position
			temp.rotation_degrees = pointer.rotation_degrees + 90
			temp.setup(ray.get_collision_point() - position)
			shot_timer.start()



func _on_ShotDelay_timeout():
	can_shoot = true
