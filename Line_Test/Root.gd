extends Node2D

const SCALING: int = 25

var line_color = Color("#ffffff")
var line_to_draw: PoolStringArray = ['0.1 * pow(x, 2)', '0.1 * pow(x, 3)', 'sin(x)', 'cos(x)']

func put_pixel(x: float, y: float, color: Color):
	draw_primitive([Vector2(x, y)], [color], PoolVector2Array())

func draw_line_dda(va: Vector2, vb: Vector2, _line_color: Color):
	var dx = vb.x - va.x
	var dy = vb.y - va.y
	
	if dx == 0 and dy == 0:
		return
	
	var xIncrement: float
	var yIncrement: float
	
	var x: float = va.x
	var y: float = va.y
	
	var steps
	if abs(dx) > abs(dy):
		steps = abs(dx)
	else:
		steps = abs(dy)
	
	xIncrement = dx / steps
	yIncrement = dy / steps
	
	put_pixel(to_godot_x(x), to_godot_y(y), _line_color)
	for _k in range(0, steps):
		x += xIncrement
		y += yIncrement
		put_pixel(to_godot_x(x), to_godot_y(y), _line_color)

func draw_line_bresenham(va: Vector2, vb: Vector2, _line_color: Color):
	var dx: int = abs(va.x - vb.x)
	var dy: int = abs(va.y - vb.y)
	
	var p: int = 2 * dy - dx
	var twoDy: int = 2 * dy
	var twoDyDx: int = 2 * (dy - dx)
	
	var x: int
	var y: int
	var xEnd: int
	
	if va.x > vb.x:
		x = vb.x
		y = vb.y
		xEnd = va.x
	else:
		x = va.x
		y = va.y
		xEnd = vb.x
	put_pixel(to_godot_x(x), to_godot_y(y), _line_color)
	
	while x < xEnd:
		x += 1
		
		if p < 0:
			p += twoDy
		else:
			y += 1
			p += twoDyDx
		
		put_pixel(to_godot_x(x), to_godot_y(y), _line_color)

func draw_line_midpoint(va: Vector2, vb: Vector2, _line_color: Color):
	var dx: int = vb.x - va.x
	var dy: int = vb.y - va.y
	var d: int = dy - (dx / 2)
	
	var x: int = va.x
	var y: int = va.y
	
	put_pixel(to_godot_x(x), to_godot_y(y), _line_color)
	while (x < vb.x):
		x += 1
		
		if (d < 0):
			d += dy
		else:
			d += (dy - dx)
			y += 1
		
		put_pixel(to_godot_x(x), to_godot_y(y), _line_color)

func draw_frame(_margin: int):
	var viewport_size = get_viewport_rect().size
	
	# Cartesian Line
	var center_x = viewport_size.x / 2
	var center_y = viewport_size.y / 2
	
	draw_line(Vector2(center_x, _margin), Vector2(center_x, viewport_size.y - _margin), line_color)
	draw_line(Vector2(_margin, center_y), Vector2(viewport_size.x - _margin, center_y), line_color)

func to_godot_x(x: float) -> float:
	var viewport_size = get_viewport_rect().size
	
	return (viewport_size.x / 2 ) + x

func to_godot_y(y: float) -> float:
	var viewport_size = get_viewport_rect().size
	
	return (viewport_size.y / 2) - y

func scaled(vec: Vector2) -> Vector2:
	return vec * SCALING

func _draw():
	draw_frame(0)
	
	var viewport_size = get_viewport_rect().size
	var center_x = viewport_size.x / 2
	var center_y = viewport_size.y / 2
	
	var center_point: Vector2 = Vector2(0, 0)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(0, 10)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(5, 10)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(10, 10)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(10, 5)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(10, 0)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(10, -5)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(10, -10)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(5, -10)),
		Color(randf(), randf(), randf())
	)
	
	draw_line_bresenham(
		center_point,
		scaled(Vector2(0, -10)),
		Color(randf(), randf(), randf())
	)
	
