extends Node2D

const SCALING = 10

var line_color = Color("#ffffff")
var line_to_draw: PoolStringArray = ['0.1 * pow(x, 2)', '0.1 * pow(x, 3)', 'sin(x)', 'cos(x)']

func put_pixel(x: float, y: float, color: Color, pixel_size: float = 2):
	var radius = pixel_size / 2
	var points_to_draw = PoolVector2Array()
	
	points_to_draw.append(Vector2(x - radius, y + radius))
	points_to_draw.append(Vector2(x + radius, y + radius))
	points_to_draw.append(Vector2(x + radius, y - radius))
	points_to_draw.append(Vector2(x - radius, y - radius))
	
	var color_for_pixel = [color, color, color, color]
	
	# parameter uvs f uv mapping (?)
	draw_primitive(points_to_draw, color_for_pixel, points_to_draw)

func draw_line_dda(va: Vector2, vb: Vector2, _line_color: Color):
	var steps: int
	
	var dx: int = vb.x - va.x
	var dy: int = vb.y - va.y
	
	if dx == 0 and dy == 0:
		return
	
	var xIncrement: float
	var yIncrement: float
	
	var x: float = va.x
	var y: float = va.y
	
	if abs(dx) > abs(dy):
		steps = abs(dx)
	else:
		steps = abs(dy)
	
	xIncrement = dx / steps
	yIncrement = dy / steps
	
	put_pixel(round(x), round(y), _line_color)
	for _k in range(0, steps):
		x += xIncrement
		y += yIncrement
		put_pixel(round(x), round(y), _line_color)

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
	put_pixel(x, y, _line_color)
	
	while x < xEnd:
		x += 1
		
		if p < 0:
			p += twoDy
		else:
			y += 1
			p += twoDyDx
		
		put_pixel(x, y, _line_color)

func draw_frame(_margin: int):
	var viewport_size = get_viewport_rect().size
	
	var top_left = Vector2(_margin, _margin)
	var top_right = Vector2(viewport_size.x - _margin, _margin)
	var bottom_left = Vector2(_margin, viewport_size.y - _margin)
	var bottom_right = Vector2(viewport_size.x - _margin, viewport_size.y - _margin)
	
	# Vertical Lines
	draw_line_dda(top_left, bottom_left, line_color)
	draw_line_dda(top_right, bottom_right, line_color)
	
	# Horizontal Lines
	draw_line_bresenham(top_left, top_right, line_color)
	draw_line_bresenham(bottom_left, bottom_right, line_color)
	
	# Cartesian Line
	var center_x = viewport_size.x / 2
	var center_y = viewport_size.y / 2
	
	draw_line_dda(Vector2(center_x, _margin), Vector2(center_x, viewport_size.y - _margin), line_color)
	draw_line_bresenham(Vector2(_margin, center_y), Vector2(viewport_size.x - _margin, center_y), line_color)

func convert_to_normal_coordinate(vec: Vector2) -> Vector2:
	var viewport_size = get_viewport_rect().size
	
	return Vector2(
	  ((viewport_size.x / 2 ) + vec.x * SCALING) , 
	  ((viewport_size.y / 2) - vec.y * SCALING) 
	)

func draw_expression(_expression: String, _margin: float, 
  steps: float = 1, _line_color: Color = Color('#ffffff')):
	var expression = Expression.new()
	expression.parse(_expression, ['x'])
	
	var y: float = expression.execute([0])
	
	var viewport_size = get_viewport_rect().size
	var viewport_length = ((viewport_size.x / 2) - _margin) / SCALING
	var viewport_height = ((viewport_size.y / 2) - _margin) / SCALING
	
	var x = steps
	while abs(x) < viewport_length and abs(y) < viewport_height:
		y = expression.execute([x])
		
		var current_position = Vector2(float(x), float(y))
		current_position = convert_to_normal_coordinate(current_position)
		
		put_pixel(current_position.x, current_position.y, _line_color)
		
		x += steps

func _draw():
	draw_frame(10)
	
	var display_string = ""
	for line_expression in line_to_draw:
		var current_color = Color(randf(), randf(), randf())
		draw_expression(line_expression, 10, 0.01, 
		  current_color)
		
		display_string += '[color=#' + current_color.to_html(false) + ']' + line_expression + '[/color]\n'
		
	$DrawnLine.bbcode_text = display_string
	
