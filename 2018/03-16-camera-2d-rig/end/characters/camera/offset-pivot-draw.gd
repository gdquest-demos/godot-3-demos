extends Position2D

export(float) var LINE_LENGTH = 40
export(String) var LINE_COLOR_HEX = '#FFEB3B'

func _ready():
	pass

func _draw():
	var half_line_length = LINE_LENGTH / 2
	var color = Color(LINE_COLOR_HEX)
	draw_line( Vector2(-half_line_length, 0), Vector2(half_line_length, 0), color, 3.0)
	draw_line( Vector2(0, -half_line_length), Vector2(0, half_line_length), color, 3.0)
