extends Area2D
"""
Frees itself when it collides with the Player
"""


func _on_body_entered(body: PhysicsBody2D) -> void:
	queue_free()
