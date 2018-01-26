extends KinematicBody2D

const MAX_SPEED = 300
const MAX_FORCE = 0.05
const ARRIVAL_RADIUS = 100

var velocity = Vector2()
var target = Vector2(500, 500)

func _ready():
    set_fixed_process(true)

func _fixed_process(delta):
    if Input.is_mouse_button_pressed(0):
        target = get_viewport().get_mouse_pos()

    var desired_velocity = Vector2(target - get_pos()).normalized() * MAX_SPEED

    var distance_to_target = get_pos().distance_to(target)
    if distance_to_target < ARRIVAL_RADIUS:
        desired_velocity *= min(1.0,distance_to_target / ARRIVAL_RADIUS)

    var steer = desired_velocity - velocity
    velocity += steer * MAX_FORCE

    move(velocity * delta)
