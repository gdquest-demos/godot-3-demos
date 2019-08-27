extends StaticBody2D


var can_shoot:= true


export var rotate_speed:= 90.0
export var turret_shot: PackedScene

onready var pointer:= $Pointer
onready var ray:= $Pointer/RayCast2D
onready var shot_timer:= $ShotTimer


func _ready():
	pass # Replace with function body.


func _process(delta):
	pointer.rotation_degrees += rotate_speed * delta
	shoot()


func shoot()->void:
	if can_shoot and ray.is_colliding():
		if ray.get_collider().is_in_group("Player"):
			can_shoot = false
			shot_timer.start()
			var temp = turret_shot.instance()
			add_child(temp)
			temp.global_position = global_position
			temp.rotation_degrees = pointer.rotation_degrees + 90
			temp.setup(ray.get_collision_point() - position)


func _on_ShotTimer_timeout():
	can_shoot = true



