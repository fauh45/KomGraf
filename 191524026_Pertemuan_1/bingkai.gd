extends Node2D

var window_height
var window_width

var line_color = Color("#ffffff")

# Margin for the windows
const MARGIN = 10

# Point array constants
const TOP_LEFT = 0
const TOP_RIGHT = 1
const BOTTOM_RIGHT = 2
const BOTTOM_LEFT = 3

func put_pixel(x: float, y: float, color: Color, pixel_size: float = 5):
	var radius = pixel_size / 2
	var points_to_draw = PoolVector2Array()
	
	points_to_draw.append(Vector2(x - radius, y + radius))
	points_to_draw.append(Vector2(x + radius, y + radius))
	points_to_draw.append(Vector2(x + radius, y - radius))
	points_to_draw.append(Vector2(x - radius, y - radius))
	
	var color_for_pixel = [color, color, color, color]
	
	# parameter uvs untuk uv mapping (?)
	draw_primitive(points_to_draw, color_for_pixel, points_to_draw)

func get_edge_points() -> Array:
	return [Vector2(MARGIN, MARGIN), 
		Vector2(window_width - MARGIN, MARGIN),
		Vector2(window_width - MARGIN, window_height - MARGIN),
		Vector2(MARGIN, window_height - MARGIN)]

func draw_line_pixel(start_point: Vector2, end_point: Vector2):
	var x_change = max(-1, min(1, (end_point.x - start_point.x)))
	var y_change = max(-1, min(1, (end_point.y - start_point.y)))
	
	var x_point = start_point.x
	var y_point = start_point.y
	
	while (x_point != end_point.x) or (y_point != end_point.y):
		put_pixel(x_point, y_point, line_color)
		
		x_point += x_change
		y_point += y_change

func draw_diagonal_pixel(start_point: Vector2, end_point: Vector2):
	var x_change = (end_point.x - start_point.x)
	var y_change = (end_point.y - start_point.y)
	
	var gradient = y_change / x_change
	
	var y_value
	var start_x
	var end_x
	var increment
	
	start_x = end_point.x
	end_x = start_point.x
	y_value = start_point.y
	increment = -1
	
	print (start_x, " ", end_x, " ", y_value, " ", increment)
	
	for x in range(start_x, end_x, increment):
		put_pixel(x, y_value, line_color)
		
		y_value += gradient


func _draw():
	print(get_viewport_rect().size)
	window_height = get_viewport_rect().size.y
	window_width = get_viewport_rect().size.x

	var edge_points = get_edge_points()
	print(edge_points)
	
	# Horizontal line
	draw_line_pixel(edge_points[TOP_LEFT], edge_points[TOP_RIGHT])
	draw_line_pixel(edge_points[BOTTOM_LEFT], edge_points[BOTTOM_RIGHT])
	
	# Vertical line
	draw_line_pixel(edge_points[BOTTOM_LEFT], edge_points[TOP_LEFT])
	draw_line_pixel(edge_points[BOTTOM_RIGHT], edge_points[TOP_RIGHT])
	
	# Diagonal line
	draw_diagonal_pixel(edge_points[TOP_LEFT], edge_points[BOTTOM_RIGHT])
	draw_diagonal_pixel(edge_points[BOTTOM_LEFT], edge_points[TOP_RIGHT])
