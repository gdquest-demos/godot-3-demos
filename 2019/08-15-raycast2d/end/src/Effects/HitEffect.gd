extends Node2D

onready var particle:= $Particles2D


func _ready():
	particle.emitting = true


func _on_Timer_timeout():
	queue_free()
