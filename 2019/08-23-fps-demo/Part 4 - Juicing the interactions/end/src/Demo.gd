extends Spatial

"""
This is the main script for the Demo scene.  This accepts a signal
from the player to generate a decal at a set position with a rotation
equal to the raycast's collision normal.  However, it seems to be a bit
buggy.  The rotation of the decal seems to only be correct on 
some surfaces, and especially incorrect with the ground.  

I'm sure this has to do with the degrees property, but I'm not too sure what.

Feedback is appreciated.
"""


export var hit_effect: PackedScene
export var hit_particle: PackedScene


func generate_hit_effect(hit_position: Vector3, hit_rotation: Vector3)->void:
	var temp = hit_effect.instance()
	temp.translation = hit_position
	temp.rotation = hit_rotation
	add_child(temp)


func generate_hit_particle(hit_position: Vector3, hit_rotation: Vector3)->void:
	var temp = hit_particle.instance()
	temp.translation = hit_position
	add_child(temp)


func _on_Player_shot_fired(hit_position: Vector3, hit_rotation: Vector3):
	generate_hit_effect(hit_position, hit_rotation)
	generate_hit_particle(hit_position, hit_rotation)
