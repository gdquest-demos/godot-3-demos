extends Sprite


func _ready():
	set_pos(OS.get_window_size() / 2)


func change_color(name):
	set_texture(load("res://Characters/%s.png" % name))