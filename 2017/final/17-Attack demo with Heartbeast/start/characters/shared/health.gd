# Manages a character's health and death. Used by the UI to draw lifebars on any character or enemy
extends Node

signal dead

export var life = 0
export var max_life = 10
export var armor = 0


func take_damage(damage):
	life = life - damage + armor
	if life < 0:
		emit('dead')

func heal(amount):
	life += amount
	if life > max_life:
		life = max_life

func get_health_ratio():
	return life / max_life