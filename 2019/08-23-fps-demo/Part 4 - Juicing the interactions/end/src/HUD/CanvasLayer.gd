extends CanvasLayer

onready var y_label:= $PlayerYDegrees
onready var x_degrees:= $CamXDegrees

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_cam_x(new_degrees: float):
	x_degrees.text = String(new_degrees)


func _on_Player_cam_y(new_degrees: float):
	y_label.text = String(new_degrees)
