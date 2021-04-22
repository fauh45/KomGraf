extends Node2D

const MARGIN = 10
const SCALING = 10
const STEPS = 0.1

var line_color = Color("#ffffff")
var line_to_draw: PoolStringArray = ['0.1 * pow(x, 2)', '0.1 * pow(x, 3)', 'sin(x)', 'cos(x)']

var current_line_index: int = 0
var current_steps: int = 0

func put_pixel(x: float, y: float, color: Color):
	draw_primitive([Vector2(x, y)], [color], [])

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
	
	var y: int = va.y
	var eps: int = 0
	
	for x in range(va.x, vb.x):
		put_pixel(x, y, _line_color)
		eps += dy
		
		if (eps << 1) >= dx:
			y += 1
			eps -= dx
	
func draw_frame(_margin: int):
	var viewport_size = get_viewport_rect().size
	
	var top_left = Vector2(_margin, _margin)
	var top_right = Vector2(viewport_size.x - _margin, _margin)
	var bottom_left = Vector2(_margin, viewport_size.y - _margin)
	var bottom_right = Vector2(viewport_size.x - _margin, viewport_size.y - _margin)
	
	# Vertical Lines
	draw_line_bresenham(top_left, bottom_left, line_color)
	draw_line_bresenham(top_right, bottom_right, line_color)
	
	# Horizontal Lines
	draw_line_bresenham(top_left, top_right, line_color)
	draw_line_dda(bottom_left, bottom_right, line_color)
	
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
	
	var steps_shift = current_steps * steps
	var y: float = expression.execute([steps_shift])
	
	var viewport_size = get_viewport_rect().size
	var viewport_length = ((viewport_size.x / 2) - _margin) / SCALING
	var viewport_height = ((viewport_size.y / 2) - _margin) / SCALING
	
	var x = steps
	while abs(x) < viewport_length and abs(y) < viewport_height:
		y = expression.execute([x + steps_shift])
		
		var current_position = Vector2(float(x), float(y))
		current_position = convert_to_normal_coordinate(current_position)
		
		put_pixel(current_position.x, current_position.y, _line_color)
		
		x += steps

func _process(delta):
	current_steps -= 1
	
	update()

func _draw():
	draw_frame(MARGIN)
	draw_expression(line_to_draw[current_line_index], MARGIN, STEPS)
	
	$ShownLine.text = String(current_line_index + 1) + '. ' + line_to_draw[current_line_index]

func _on_NextButton_pressed():
	current_line_index = (current_line_index + 1) % line_to_draw.size()
	current_steps = 0
	
	update()

func _on_AddButton_pressed():
	line_to_draw.append($LineInput.text)
	$LineInput.text = ""
