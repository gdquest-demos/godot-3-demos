extends CharacterBody2D
@onready var sprite :Sprite2D=$TriangleRed
var _velocity:Vector2 = Vector2(0,0)
var vel :Vector2 = Vector2(20,50)
const DISTANCE_THRESHOLD:int = 3


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

	
func _physics_process(_delta)->void:
	var target_global_position :Vector2 = get_global_mouse_position()
	_velocity = StreerigNode._follow(
		_velocity,
		global_position,
		target_global_position
	)
	if global_position.distance_to(target_global_position)<DISTANCE_THRESHOLD:
		return
	sprite.rotation=_velocity.angle()
	set_velocity(_velocity)
	move_and_slide()
	_velocity=velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
