tool
extends KinematicBody2D

var speed = 400
var time = 0.0

var start_position = Vector2()

export(float) var sine_amplitude = 80 setget _set_sine_amplitude


func _ready():
	start_position = position


func _physics_process(delta):
	if Engine.editor_hint:
		return
	time += delta
	position.x += speed * delta
	position.y =  start_position.y + sin(time * 10) * sine_amplitude


func _set_sine_amplitude(value):
	sine_amplitude = value
	update()
