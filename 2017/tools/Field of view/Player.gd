extends KinematicBody2D


const DETECT_RADIUS = 200
const FOV = 80

var angle = 0
var direction = Vector2()

var draw_color = GREEN
const RED = Color(1.0, 0, 0, 0.4)
const GREEN = Color(0, 1.0, 0, 0.4)


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	var pos = get_pos()
	direction = (get_global_mouse_pos() - pos).normalized()
	angle = 90 - rad2deg(direction.angle())
	print(angle)

	var detect_count = 0
	for node in get_tree().get_nodes_in_group('detectable'):
		if pos.distance_to(node.pos) < DETECT_RADIUS:
			var dot_product = direction.dot(node.direction)
			var angle_to_node = rad2deg(acos(dot_product))
			if angle_to_node < FOV/2:
				detect_count += 1
	
	# DRAWING
	if detect_count > 0:
		draw_color = RED
	else:
		draw_color = GREEN
	update()




# Drawing the FOV
func _draw():
	draw_circle_arc_poly(Vector2(), DETECT_RADIUS,  angle - FOV/2, angle + FOV/2, draw_color)


func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = Vector2Array()
    points_arc.push_back(center)
    var colors = ColorArray([color])

    for i in range(nb_points+1):
        var angle_point = angle_from + i*(angle_to-angle_from)/nb_points
        points_arc.push_back(center + Vector2( cos( deg2rad(angle_point) ), sin( deg2rad(angle_point) ) ) * radius)
    draw_polygon(points_arc, colors)