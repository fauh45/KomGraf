extends Node2D

class_name Lines

const LineParams = preload("res://LineParams.gd")


func put_pixel(x, y, color):
	draw_primitive([Vector2(x, y)], [color], [])


func draw_line_custom(
	va: Vector2,
	vb: Vector2,
	_line_color: Color,
	thickness: float = 1,
	dotted: bool = false,
	dash: int = 1,
	gap: int = 0
):
	var steps

	var dx = vb.x - va.x
	var dy = vb.y - va.y
	
	if dx == 0 and dy == 0:
		return
	
	var x = va.x
	var y = va.y

	var upper_bounds: Vector2
	var lower_bounds: Vector2

	thickness = thickness / 2

	if dx == 0:
		upper_bounds = Vector2(x - thickness, y)
		lower_bounds = Vector2(x + thickness, y)
	elif dy == 0:
		upper_bounds = Vector2(x, y + thickness)
		lower_bounds = Vector2(x, y - thickness)
	else:
		var m: float = dy / dx
		var m_p: float = (-1) * (1 / m)

		var tmp = thickness / sqrt(1 + pow(m_p, 2))

		var x_lb = tmp + x
		var x_ub = -tmp + x

		var y_lb = (m_p * (x_lb - x)) + y
		var y_ub = (m_p * (x_ub - x)) + y

		upper_bounds = Vector2(x_ub, y_ub)
		lower_bounds = Vector2(x_lb, y_lb)

	if abs(dx) > abs(dy):
		steps = abs(dx)
	else:
		steps = abs(dy)

	var xIncrement = dx / steps
	var yIncrement = dy / steps

	var i = 1
	var skip = dash

	put_pixel(round(x), round(y), _line_color)
	while i <= steps:
		if i == skip and dotted:
			var x_add = xIncrement * gap
			var y_add = yIncrement * gap

			upper_bounds.x += x_add
			upper_bounds.y += y_add

			lower_bounds.x += x_add
			lower_bounds.y += y_add

			skip += dash + gap
			i += gap
		else:
			var x_add = xIncrement
			var y_add = yIncrement

			upper_bounds.x += x_add
			upper_bounds.y += y_add

			lower_bounds.x += x_add
			lower_bounds.y += y_add

			i += 1

			draw_thickness(upper_bounds, lower_bounds, _line_color)


func draw_thickness(start: Vector2, end: Vector2, color: Color):
	var dy = end.y - start.y
	var dx = end.x - start.x

	var steps = abs(dx) if (abs(dx) > abs(dy)) else abs(dy)

	var x = start.x
	var y = start.y

	put_pixel(x, y, color)

	if steps > 0:
		var x_inc = dx / steps
		var y_inc = dy / steps

		for i in steps:
			x += x_inc
			y += y_inc

			put_pixel(round(x), round(y), color)


func draw_line_from_params(params: LineParams):
	draw_line_custom(
		params.start,
		params.end,
		params.color,
		params.thickness,
		params.dotted,
		params.dash,
		params.gap
	)
