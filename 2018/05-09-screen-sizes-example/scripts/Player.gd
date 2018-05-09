extends KinematicBody2D

export(float) var SPEED = 150
var move_direction = Vector2(0, 0)

func _physics_process(delta):
	var velocity = move_direction * SPEED
	move_and_slide(velocity)


func _on_TouchButtons_input_direction_changed(new_input_direction):
	move_direction = new_input_direction
