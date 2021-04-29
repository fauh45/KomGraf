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
	
	img.lock()
	var curr_pixel_color = img.get_pixel(x, y)
	print("x: ", x, ", y: ", y, ", color: ", curr_pixel_color, ", boundary: ", boundary_color)
	
	# var rounded_up_pixel_color = Color(round(curr_pixel_color.r), round(curr_pixel_color.g), round(curr_pixel_color.b))
	if !curr_pixel_color.is_equal_approx(boundary_color):
		put_pixel(x, y, fill_color)
		print("x: ", x, ", y: ", y, ", color: ", curr_pixel_color, ", boundary: ", boundary_color)
	
