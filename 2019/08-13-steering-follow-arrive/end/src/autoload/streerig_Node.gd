extends Node

const default_mass:int=5                                                                                                                                                                                                                                                                                                                                          
const default_max_speed = 400.0
const DEFAULT_SLOW_RADIUS:int = 400
func _follow(
	velocity:Vector2, 
	global_position:Vector2,
	target_position:Vector2,
	max_speed:=default_max_speed,
	mass:=default_mass
)->Vector2:
	var desired_velocity:= (target_position-global_position).normalized()*max_speed
	var streering:= (desired_velocity-velocity)/mass
	return velocity+streering
func arrive_to(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
	velocity:Vector2, 
	global_position:Vector2,
	target_position:Vector2,
	Slow_Radius:int=DEFAULT_SLOW_RADIUS,
	max_speed:=default_max_speed,
	mass:=default_mass
)->Vector2:
	var to_target:= global_position.distance_to(target_position)
	var desired_velocity:= (target_position-global_position).normalized()*max_speed
	if to_target< Slow_Radius:
		desired_velocity = desired_velocity*(to_target/Slow_Radius)
	var streering:= (desired_velocity-velocity)/mass
	return velocity+streering
