extends Node2D

onready var SpawnInterval = $SpawnInterval
var Enemy = preload("res://scenes/Enemy.tscn")

#Rng values 
const MAX_SPAWN_INTERVAL = 3
const MIN_SPAWN_INTERVAL = 1.5

enum { TOP_BOTTOM, BOTTOM_TOP, LEFT_RIGHT, RIGHT_LEFT } 
export(Direction) var direction

func _ready():
	randomize()
	SpawnInterval.wait_time = rand_range(MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL)

#spawn a new enemy
func _on_SpawnInterval_timeout():
	var enemy = Enemy.instance()
	match direction:
		Direction.BOTTOM_TOP:
			enemy.direction_x = 0
			enemy.direction_y = -1
		Direction.TOP_BOTTOM:
			enemy.direction_x = 0
			enemy.direction_y = 1
		Direction.LEFT_RIGHT:
			enemy.direction_x = 1
			enemy.direction_y = 0
		Direction.RIGHT_LEFT:
			enemy.direction_x = -1
			enemy.direction_y = 0
	add_child(enemy)
	SpawnInterval.wait_time = rand_range(MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL)
