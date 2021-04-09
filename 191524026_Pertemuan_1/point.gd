extends Node2D

var point_color = Color("#ffffff")
var x_y_array = []

func put_pixel(x: float, y: float, color: Color, pixel_size: float = 5):
	var radius = pixel_size / 2
	var points_to_draw = PoolVector2Array()
	
	points_to_draw.append(Vector2(x - radius, y + radius))
	points_to_draw.append(Vector2(x + radius, y + radius))
	points_to_draw.append(Vector2(x + radius, y - radius))
	points_to_draw.append(Vector2(x - radius, y - radius))
	
	var color_for_pixel = [color, color, color, color]
	
	# parameter uvs f uv mapping (?)
	draw_primitive(points_to_draw, color_for_pixel, points_to_draw)

func _draw():
	for coordinates in x_y_array:
		put_pixel(coordinates[0], coordinates[1], point_color)

func _input(event):
	# Check if mouse is clicked and the node is active
	if event is InputEventMouseButton and self.is_visible_in_tree():
		# Preventing double click
		if event.is_pressed():
			x_y_array.append([event.position.x, event.position.y])
			update()


func _on_ClearButton_pressed():
	x_y_array.clear()
	update()
