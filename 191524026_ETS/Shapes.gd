extends Node2D

class_name Shapes


func draw_circle_midpoint(radius: float, center_point: Vector2, params: CircleParams):
	var points = CirclePoints.new(params)

	var x = radius
	var y = 0

	var P = 5 / 4 - radius

	put_pixel_every_octane(x, y, center_point, params, points)
	while x > y:
		y += 1

		if P <= 0:
			P = P + 2 * y + 1
		else:
			x -= 1
			P = P + 2 * y - 2 * x + 1

		if x < y:
			break

		put_pixel_every_octane(x, y, center_point, params, points)

	for i in range(8):
		if points.temp_points[i].size() > 1:
			draw_polyline(points.temp_points[i], params.color_of_octane[i], params.line_width, true)


func put_pixel_every_octane(
	x: float, y: float, center_point: Vector2, params: CircleParams, points: CirclePoints
):
	var to_draw = params.octane_to_draw

	# Octane 1
	if to_draw[0]:
		points.add_point_to_octane(0, Vector2(y + center_point.x, x + center_point.y))

	# Octane 2
	if to_draw[1]:
		points.add_point_to_octane(1, Vector2(x + center_point.x, y + center_point.y))

	# Octane 3
	if to_draw[2]:
		points.add_point_to_octane(2, Vector2(x + center_point.x, -y + center_point.y))

	# Octane 4
	if to_draw[3]:
		points.add_point_to_octane(3, Vector2(y + center_point.x, -x + center_point.y))

	# Octane 5
	if to_draw[4]:
		points.add_point_to_octane(4, Vector2(-y + center_point.x, -x + center_point.y))

	# Octane 6
	if to_draw[5]:
		points.add_point_to_octane(5, Vector2(-x + center_point.x, -y + center_point.y))

	# Octane 7
	if to_draw[6]:
		points.add_point_to_octane(6, Vector2(-x + center_point.x, y + center_point.y))

	# Octane 8
	if to_draw[7]:
		points.add_point_to_octane(7, Vector2(-y + center_point.x, x + center_point.y))


static func config_draw_only(octanes: PoolIntArray) -> CircleParams:
	var params = CircleParams.new()

	for i in range(8):
		params.octane_to_draw[i] = i in octanes

	return params
