extends KinematicBody2D
"""
Player-controled character. Moves in 4 direction and 
gets knocked back when it takes damage.
"""


onready var stun_timer: Timer = $StunTimer
onready var tween: Tween = $Tween

export var speed: = 500.0

var speed_multiplier: = 1.0 setget set_speed_multiplier


func _process(delta):
	move()


func move():
	var direction: = Vector2.ZERO
	if stun_timer.is_stopped():
		direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()

	var velocity = direction * speed * speed_multiplier
	move_and_slide(velocity, Vector2.UP)


func set_speed_multiplier(multiplier):
	speed_multiplier = max(multiplier, 0)


func stun(duration: = 0.3):
	stun_timer.wait_time = duration
	stun_timer.start()


func knock_back(direction: Vector2):
	var distance: = 100.0
	tween.interpolate_property(
		self, "position", 
		position, position + direction * distance, 0.3, Tween.TRANS_SINE, 
		Tween.EASE_OUT)
	tween.start()


func _on_HurtBox_area_entered(area):
	var knock_direction = (position - area.position).normalized()
	stun()
	knock_back(knock_direction)
