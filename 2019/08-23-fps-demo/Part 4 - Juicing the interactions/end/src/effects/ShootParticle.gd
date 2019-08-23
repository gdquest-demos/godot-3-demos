extends Spatial

onready var particles:= $Particles

# Called when the node enters the scene tree for the first time.
func _ready():
	particles.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
