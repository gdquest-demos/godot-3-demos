extends Node2D


export var hit_particle: PackedScene


func create_hit_particle(particle_position: Vector2):
	var temp = hit_particle.instance()
	temp.position = particle_position
	add_child(temp)


func _on_Player_make_hit_effect(particle_position: Vector2):
	create_hit_particle(particle_position)
