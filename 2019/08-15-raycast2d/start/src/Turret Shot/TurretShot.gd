extends Area2D

export var speed:= 500.0

var movement_direction:= Vector2.ZERO


func _ready():
	pass # Replace with function body.


func _process(delta):
	position += movement_direction.normalized() * speed * delta


func setup(point_direction: Vector2)->void:
	movement_direction = point_direction
