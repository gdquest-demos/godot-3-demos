# Don't use this code as a reference for behaviors. It won't scale well.
# It's meant to show a way to use Tween (animation) and make gameplay out of it (pattern-based, enemy motion)
extends Node2D

var direction = Vector2()
var target_pos = Vector2()

# We get a reference to the Tween node
onready var TweenNode = get_node("Tween")
onready var Player = get_tree().get_root().get_node("./Game/Player")

enum STATES {IDLE, PREPARE, ATTACK, REST}
var state = IDLE

const REST_TIME = 1.0
var rest_timer = REST_TIME

const PREPARE_TIME = 1.2
var prepare_timer = PREPARE_TIME


func _ready():
	set_process(true)


func _process(delta):
	# When not resting, look towards the player
	if state in [IDLE, REST]:
		direction = (Player.get_pos() - get_pos()).normalized()
	
	if state == IDLE and Player.is_idle():
		go_to_state(PREPARE)
	elif state == PREPARE:
		prepare_timer -= delta
		if prepare_timer <= 0:
			go_to_state(ATTACK)
	elif state == REST:
		rest_timer -= delta
		if rest_timer <= 0:
			go_to_state(IDLE)


func go_to_state(new_state):
	state = new_state
	if new_state == REST:
		rest_timer = REST_TIME
	elif new_state == PREPARE:
		prepare_timer = PREPARE_TIME
		target_pos = Player.get_pos()
	# We start the Tween upon entering the ATTACK state
	elif new_state == ATTACK:
		move_to(target_pos)


func move_to(target_pos):
	# Here's where the tween happens. Only 2 lines for a bouncy animation (thanks to the elastic easing equation)
	# Tweening the yellow circle (self), its positon parameter, from the current position to the target (last stored player position),
	# for 1 second, using an elastic ease out
	TweenNode.interpolate_property(self, "transform/pos", get_pos(), target_pos, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	# Always start the animation, otherwise nothing happens. The method above merely initializes the tween
	TweenNode.start()


# We use a signal to detect when the tween ends. Then, we change the yellow circle's state.
func _on_Tween_tween_complete( object, key ):
	go_to_state(REST)
