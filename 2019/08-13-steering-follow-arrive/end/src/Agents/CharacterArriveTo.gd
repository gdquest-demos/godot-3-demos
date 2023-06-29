extends CharacterBody2D
@onready var sprite :Sprite2D=$TriangleRed
var _velocity:Vector2 = Vector2(0,0)
var vel :Vector2 = Vector2(20,50)
const DISTANCE_THRESHOLD:int = 3
const SLOW_RADIUS:int = 200
var target_global_position :Vector2 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		set_physics_process(true)
		target_global_position = get_global_mouse_position()

	
func _physics_process(_delta)->void:

	_velocity = StreerigNode.arrive_to(
		_velocity,
		global_position,
		target_global_position,
		SLOW_RADIUS
	)
	if global_position.distance_to(target_global_position)<DISTANCE_THRESHOLD:
		set_physics_process(false)
	sprite.rotation=_velocity.angle()
	set_velocity(_velocity)
	move_and_slide()
	_velocity=velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
