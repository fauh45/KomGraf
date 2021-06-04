class_name CircleParams

var octane_to_draw = []
var color_of_octane = PoolColorArray()
var line_width: float = 1.0
var rotation: float = 0.0
var rotation_center: Vector2 = Vector2()


func _init(
	draw_octane: Array = [],
	octane_color: PoolColorArray = [],
	width: float = 1.0,
	rotation_value: float = 0,
	anchor_point: Vector2 = Vector2()
):
	if draw_octane.size() < 8:
		initialize_octane_to_draw()
	else:
		octane_to_draw = draw_octane

	if octane_color.size() < 8:
		initialize_octene_color()
	else:
		color_of_octane = octane_color

	line_width = width
	rotation = rotation_value
	rotation_center = anchor_point


func randomize_color():
	for i in range(8):
		randomize()
		color_of_octane[i] = Color(randf(), randf(), randf())


func set_color_to_all(color: Color):
	for i in range(8):
		color_of_octane[i] = color


func set_width(width: float):
	line_width = width


func set_rotation(rotation_value: float, rotation_achor: Vector2):
	rotation = rotation_value
	rotation_center = rotation_achor


func initialize_octane_to_draw():
	for _i in range(8):
		octane_to_draw.append(true)


func initialize_octene_color():
	for _i in range(8):
		color_of_octane.append(Color.white)
