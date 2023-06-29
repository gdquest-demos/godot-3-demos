extends Area2D
@onready var Animation_player:AnimationPlayer =$AnimationPlayer
func _ready():
	visible=false

func _on_Area2D_body_entered(_body):
	Animation_player.play("fade_out")
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		Animation_player.stop()
		Animation_player.play("fade_in")
func _physics_process(_delta):
	if Input.is_action_pressed("click"):
		Animation_player.play("fade_in")
		global_position = get_global_mouse_position()
