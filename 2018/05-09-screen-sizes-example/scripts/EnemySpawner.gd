extends Node2D

enum { TOP_BOTTOM, BOTTOM_TOP, LEFT_RIGHT, RIGHT_LEFT } 
export(DIRECTIONS) var direction

export(float) var MINIMUM_SPAWN_INTERVAL = 1.5
export(float) var MAXIMUM_SPAWN_INTERVAL = 3

var enemy_scene = preload("res://scenes/Enemy.tscn")

func _ready():
	randomize()
	$SpawnInterval.wait_time = rand_range(MINIMUM_SPAWN_INTERVAL, MAXIMUM_SPAWN_INTERVAL)


func spawn_new_enemy():
	var new_enemy = enemy_scene.instance()
	match direction:
		DIRECTIONS.BOTTOM_TOP:
			new_enemy.direction = Vector2(0, -1)
		DIRECTIONS.TOP_BOTTOM:
			new_enemy.direction = Vector2(0, 1)
		DIRECTIONS.LEFT_RIGHT:
			new_enemy.direction = Vector2(1, 0)
		DIRECTIONS.RIGHT_LEFT:
			new_enemy.direction = Vector2(-1, 0)
	add_child(new_enemy)


func _on_SpawnInterval_timeout():
	spawn_new_enemy()
	$SpawnInterval.wait_time = rand_range(MINIMUM_SPAWN_INTERVAL, MAXIMUM_SPAWN_INTERVAL)

