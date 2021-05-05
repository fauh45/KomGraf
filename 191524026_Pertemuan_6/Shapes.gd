extends Lines

class_name Shapes

const CircleParams = preload("res://CircleParams.gd")
const EllipseParams = preload("res://EllipseParams.gd")
const Utils = preload("res://Utils.gd")

func draw_points(
	points: PoolVector2Array,
	color: Color,
	thickness: float = 1,
	dotted: bool = false,
	dash: int = 1,
	gap: int = 0
):
	var points_size = points.size()
	for i in range(points_size):
		var start = points[i]
		var end = points[(i + 1) % points.size()]

		draw_line_custom(start, end, color, thickness, dotted, dash, gap)


func draw_triangle(left_point: Vector2, length: float, color: Color = Color.white):
	var points = [left_point]
	
	points.append(Utils.translate(left_point, Vector2(length, 0)))
	points.append(Utils.rotate(left_point, points[1], 60))
	
	draw_points(points, color)


func draw_rhombus(top_point: Vector2, length: float, color: Color = Color.white):
	var points = [top_point]
	var bottom_points = Utils.translate(top_point, Vector2(0, length))
	
	points.append(Utils.rotate(top_point, bottom_points, 60))
	points.append(bottom_points)
	points.append(Utils.rotate(top_point, bottom_points, -60))
	
	draw_points(points, color)


func draw_circle_midpoint(radius: float, center_point: Vector2, params: CircleParams):
	var x = radius
	var y = 0

	var P = 5 / 4 - radius

	put_pixel_every_octane(x, y, center_point, params)
	while x > y:
		y += 1

		if P <= 0:
			P = P + 2 * y + 1
		else:
			x -= 1
			P = P + 2 * y - 2 * x + 1

		if x < y:
			break

		put_pixel_every_octane(x, y, center_point, params)


func put_pixel_every_octane(x: float, y: float, center_point: Vector2, params: CircleParams):
	var colors = params.color_of_octane
	var to_draw = params.octane_to_draw

	# Octane 1
	if to_draw[0]:
		put_pixel(y + center_point.x, x + center_point.y, colors[0])

	# Octane 2
	if to_draw[1]:
		put_pixel(x + center_point.x, y + center_point.y, colors[1])

	# Octane 3
	if to_draw[2]:
		put_pixel(x + center_point.x, -y + center_point.y, colors[2])

	# Octane 4
	if to_draw[3]:
		put_pixel(y + center_point.x, -x + center_point.y, colors[3])

	# Octane 5
	if to_draw[4]:
		put_pixel(-y + center_point.x, -x + center_point.y, colors[4])

	# Octane 6
	if to_draw[5]:
		put_pixel(-x + center_point.x, -y + center_point.y, colors[5])

	# Octane 7
	if to_draw[6]:
		put_pixel(-x + center_point.x, y + center_point.y, colors[6])

	# Octane 8
	if to_draw[7]:
		put_pixel(-y + center_point.x, x + center_point.y, colors[7])


static func config_draw_only(octanes: PoolIntArray) -> CircleParams:
	var params = CircleParams.new()

	for i in range(8):
		params.octane_to_draw[i] = i in octanes

	return params

func boundary_fill(starting_position: Vector2, boundary_color: Color, fill_color: Color):
	var img = get_viewport().get_texture().get_data()

	var x = starting_position.x
	var y = starting_position.y
	
	img.flip_y()
	img.lock()
	var curr_pixel_color = img.get_pixel(x, y)
	print("x: ", x, ", y: ", y, ", color: ", curr_pixel_color, ", boundary: ", boundary_color)
	
	if !curr_pixel_color.is_equal_approx(boundary_color):
		put_pixel(x, y, fill_color)
		print("x: ", x, ", y: ", y, ", color: ", curr_pixel_color, ", boundary: ", boundary_color)
		
		boundary_fill(Vector2(x + 1, y), boundary_color, fill_color)
		boundary_fill(Vector2(x - 1, y), boundary_color, fill_color)
		
		boundary_fill(Vector2(x, y + 1), boundary_color, fill_color)
		boundary_fill(Vector2(x, y - 1), boundary_color, fill_color)
		


func draw_ellipse_midpoint(rx: float, ry: float, center_point: Vector2, params: EllipseParams):
	var x = 0
	var y = ry
	
	var ry_square = ry * ry
	var rx_square = rx * rx
	
	var d1 = ((ry * ry) - (rx * rx * ry) + (0.25 * rx * rx))
	var dx = 2 * ry * ry * x
	var dy = 2 * rx * rx * y
	
	# While m < -1, Region 1
	while(dx < dy):
		put_pixel_every_quadrant(x, y, center_point, params)
		
		if d1 < 0:
			x += 1
			dx = dx + (2 * ry * ry)
			d1 = d1 + dx + (ry * ry)
		else:
			x += 1
			y -= 1
			dx = dx + (2 * ry * ry)
			dy = dy - (2 * rx * rx)
			d1 = d1 + dx - dy + (ry * ry)
  
	
	var d2 = (((ry * ry) * ((x + 0.5) * (x + 0.5))) +
		  ((rx * rx) * ((y - 1) * (y - 1))) - 
		   (rx * rx * ry * ry))
	
	while y >= 0:
		put_pixel_every_quadrant(x, y, center_point, params)
		
		if d2 > 0:
			y -= 1
			dy = dy - (2 * rx * rx)
			d2 = d2 + (rx * rx) - dy
		else:
			y -= 1
			x += 1
			dx = dx + (2 * ry * ry)
			dy = dy - (2 * rx * rx)
			d2 = d2 + dx - dy + (rx * rx)

func put_pixel_every_quadrant(x: float, y: float, center_point: Vector2, params: EllipseParams):
	var to_draw = params.quadrant_to_draw
	var colors = params.quadrant_color
	
	var points = PoolVector2Array([
		Vector2(x + center_point.x, y + center_point.y),
		Vector2(x + center_point.x, -y + center_point.y),
		Vector2(-x + center_point.x, -y + center_point.y),
		Vector2(-x + center_point.x, y + center_point.y)
	])
	
	for i in range(4):
		if !to_draw[i]:
			continue
		else:
			points[i] = Utils.rotate(points[i], center_point, params.degree)
			put_pixel(points[i].x, points[i].y, colors[i])


func draw_flower_4(rx: float, ry: float, center: Vector2, degree: float = 0, draw: Array = []):
	var params = EllipseParams.new(draw)
	params.randomize_quadrant_color()
	params.set_degree(degree)
	
	var point = Utils.translate(center, Vector2(rx, 0))
	
	draw_ellipse_midpoint(rx, ry, Utils.rotate(point, center, degree), params)
	
	params.set_degree(degree + 90)
	draw_ellipse_midpoint(rx, ry, Utils.rotate(point, center, degree + 90), params)
	
	params.set_degree(degree + 180)
	draw_ellipse_midpoint(rx, ry, Utils.rotate(point, center, degree + 180), params)
	
	params.set_degree(degree + 270)
	draw_ellipse_midpoint(rx, ry, Utils.rotate(point, center, degree + 270), params)


func draw_flower_8(rx: float, ry: float, center: Vector2):
	draw_flower_4(rx, ry, center, 0, [true, true, false, false])
	draw_flower_4(rx, ry, center, 45, [true, true, false, false])

