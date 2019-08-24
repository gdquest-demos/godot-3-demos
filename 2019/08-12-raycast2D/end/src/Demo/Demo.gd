extends Node2D


export var hit_particle: PackedScene


func create_hit_particle(particle_position: Vector2)->void:
	var temp = hit_particle.instance()
	temp.position = particle_position
	add_child(temp)


func _on_Player_shot_bullet(particle_position: Vector2)->void:
	create_hit_particle(particle_position)

