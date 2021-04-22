extends Lines

class_name Shapes


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
