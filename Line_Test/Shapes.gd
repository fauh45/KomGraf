extends Lines

class_name Shapes

const CircleParams = preload("res://CircleParams.gd")


func draw_points(
	points: PoolVector2Array,
	color: Color,
	thickness: float = 1,
	dotted: bool = false,
	dash: int = 1,
	gap: int = 0
):
	for i in range(points.size()):
		var start = points[i]
		var end = points[(i + 1) % points.size()]

		draw_line_custom(start, end, color, thickness, dotted, dash, gap)


func draw_square(
	length: float, point: Vector2, color: Color, thickness: float = 1, dash: int = 1, gap: int = 0
):
	draw_points(
		[
			point,
			Vector2(point.x + length, point.y),
			Vector2(point.x + length, point.y + length),
			Vector2(point.x, point.y + length)
		],
		color,
		thickness,
		dash > 1 and gap > 1,
		dash,
		gap
	)


func draw_rectange(
	length: float,
	width: float,
	point: Vector2,
	color: Color,
	thickness: float = 1,
	dash: int = 1,
	gap: int = 0
):
	draw_points(
		[
			point,
			Vector2(point.x + length, point.y),
			Vector2(point.x + length, point.y + width),
			Vector2(point.x, point.y + width)
		],
		color,
		thickness,
		dash > 1 and gap > 1,
		dash,
		gap
	)


func draw_parallelogram(
	base: float,
	delta: float,
	height: float,
	point: Vector2,
	color: Color,
	thickness: float = 1,
	dash: int = 1,
	gap: int = 0
):
	draw_points(
		[
			point,
			Vector2(point.x + base, point.y),
			Vector2(point.x + base - delta, point.y + height),
			Vector2(point.x - delta, point.y + height)
		],
		color,
		thickness,
		dash > 1 and gap > 1,
		dash,
		gap
	)


func draw_rhombus(
	length: float,
	height: float,
	center_point: Vector2,
	color: Color,
	thickness: float = 1,
	dash: int = 1,
	gap: int = 0
):
	var half_length = length / 2
	var half_height = height / 2

	draw_points(
		[
			Vector2(center_point.x - half_length, center_point.y),
			Vector2(center_point.x, center_point.y + half_height),
			Vector2(center_point.x + half_length, center_point.y),
			Vector2(center_point.x, center_point.y - half_height)
		],
		color,
		thickness,
		dash > 1 and gap > 1,
		dash,
		gap
	)


func draw_trapesium(
	top_base: float,
	bottom_base: float,
	height: float,
	point: Vector2,
	color: Color,
	thickness: float = 1,
	dash: int = 1,
	gap: int = 0
):
	draw_points(
		[
			point,
			Vector2(point.x + top_base, point.y),
			Vector2(point.x + bottom_base, point.y + height),
			Vector2(point.x, point.y + height)
		],
		color,
		thickness,
		dash > 1 and gap > 1,
		dash,
		gap
	)


func draw_triangle(
	height: float,
	width: float,
	point: Vector2,
	color: Color,
	thickness: float = 1,
	dash: int = 1,
	gap: int = 0
):
	draw_points(
		[point, Vector2(point.x + width, point.y + height), Vector2(point.x, point.y + height)],
		color,
		thickness,
		dash > 1 and gap > 1,
		dash,
		gap
	)


func draw_circle_midpoint(radius: float, center_point: Vector2, params: CircleParams):
	var x = 0
	var y = radius

	var P = 5 / 4 - radius

	put_pixel_every_octane(x, y, center_point, params)
	while y > x:
		x += 1

		if P <= 0:
			P = P + 2 * x + 3
		else:
			y -= 1
			P = P + 2 * x - 2 * y - 1

		if y < x:
			break

		put_pixel_every_octane(y, x, center_point, params)


func put_pixel_every_octane(x: float, y: float, center_point: Vector2, params: CircleParams):
	var colors = params.color_of_octane
	var to_draw = params.octane_to_draw

	# Octane 0
	if to_draw[0]:
		put_pixel(y + center_point.x, x + center_point.y, colors[0])

	# Octane 1
	if to_draw[1]:
		put_pixel(x + center_point.x, y + center_point.y, colors[1])

	# Octane 2
	if to_draw[2]:
		put_pixel(x + center_point.x, -y + center_point.y, colors[2])

	# Octane 3
	if to_draw[3]:
		put_pixel(y + center_point.x, -x + center_point.y, colors[3])

	# Octane 4
	if to_draw[4]:
		put_pixel(-y + center_point.x, -x + center_point.y, colors[4])

	# Octane 5
	if to_draw[5]:
		put_pixel(-x + center_point.x, -y + center_point.y, colors[5])

	# Octane 6
	if to_draw[6]:
		put_pixel(-x + center_point.x, y + center_point.y, colors[6])

	# Octane 7
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
		
	

func draw_ellipse_midpoint(rx: float, ry: float, center_point: Vector2, color: Color = Color.white):
	var x = 0
	var y = ry
	
	var ry_square = ry * ry
	var rx_square = rx * rx
	
	var d1 = ((ry * ry) - (rx * rx * ry) + (0.25 * rx * rx))
	var dx = 2 * ry * ry * x
	var dy = 2 * rx * rx * y
	
	# While m < -1, Region 1
	while(dx < dy):
		put_pixel_every_quadrant(x, y, center_point, color)
		
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
		put_pixel_every_quadrant(x, y, center_point, color)
		
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

func put_pixel_every_quadrant(x: float, y: float, center_point: Vector2, color: Color):
	put_pixel(x + center_point.x, y + center_point.y, color)
	put_pixel(-x + center_point.x, y + center_point.y, color)
	put_pixel(x + center_point.x, -y + center_point.y, color)
	put_pixel(-x + center_point.x, -y + center_point.y, color)
