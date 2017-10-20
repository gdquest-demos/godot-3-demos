extends KinematicBody2D

signal health_changed
signal died

export(String) var weapon_scene_path = "res://characters/weapons/spear/Spear.tscn"

var weapon = null
var weapon_path = ""

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, WALK, ATTACK, STAGGER, DIE, DEAD}
var current_state = null
var previous_state = null

var speed = 400
var look_direction = Vector2(1, 0)
var move_direction = Vector2()
var input_direction = Vector2()


export var max_health = 1
var health


func _ready():
	health = max_health

	# Weapon setup
	var weapon_instance = load(weapon_scene_path).instance()
	var weapon_anchor = $WeaponSpawnPoint/WeaponAnchorPoint
	weapon_anchor.add_child(weapon_instance)

	weapon = weapon_anchor.get_child(0)

	weapon_path = weapon.get_path()
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")

	_change_state(IDLE)



func _physics_process(delta):

	# Movement
	if current_state == IDLE:
		if input_direction:
			_change_state(WALK)

	if current_state == WALK:
		move_direction = input_direction

		if move_direction.x:
			look_direction.x = move_direction.x
			$WeaponSpawnPoint.scale.x = look_direction.x
		if move_direction.y:
			look_direction.y = move_direction.y

		if not move_direction:
			_change_state(IDLE)

		var velocity = move_direction * speed * delta
		move_and_collide(velocity)


func _change_state(new_state):
	previous_state = current_state
	current_state = new_state

	# initialize/enter the state
	match new_state:
		IDLE:
			animation_player.play("idle")
		ATTACK:
			# see Weapon.gd for damage management
			weapon.attack()
		STAGGER:
			animation_player.play("take_damage")
		DEAD:
			queue_free()


func take_damage(count):
	if current_state == DEAD:
		return

	health -= count
	if health <= 0:
		health = 0
		_change_state(DEAD)
		emit_signal("died")
		return

	_change_state(STAGGER)
	emit_signal("health_changed", health)


func _on_AnimationPlayer_animation_finished( name ):
	if name == "take_damage":
		_change_state(IDLE)


func _on_Weapon_attack_finished():
	_change_state(IDLE)
