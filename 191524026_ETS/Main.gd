extends Fish

var frames = 0

var viewport_size: Vector2
var center: Vector2

var colonies_point: PoolVector2Array
var current_speed: float = 1.5
var current_rotation: float = 0

var mouse_position: Vector2
var show_mouse_position: bool = false

const SPEED_MODIFIER: float = 3.0

var max_L: float


func _draw():
	viewport_size = get_viewport_rect().size
	center = Vector2(viewport_size.x / 2, viewport_size.y / 2)

	max_L = center.x

	if frames == 0:
		initialize_colonies_point()

	draw_colonies()
	draw_mouse_hint()


func draw_colonies():
	var point_size = colonies_point.size()

	for i in range(point_size):
		colonies_point[i] = translate_point(colonies_point[i])
		draw_fish_colonies(rotate_point(colonies_point[i]), get_current_degree(colonies_point[i].x))


func draw_mouse_hint():
	if show_mouse_position:
		draw_line(center, mouse_position, Color.white)


func translate_point(point: Vector2) -> Vector2:
	var y_translation = get_y_translation(point.x - current_speed)
	var new_point = Utils.translate(point, Vector2(-current_speed, y_translation))

	if new_point.x < -COLONIESMARGIN:
		new_point = Vector2(viewport_size.x + COLONIESMARGIN, new_point.y)

	return new_point


func rotate_point(point: Vector2) -> Vector2:
	return Utils.rotate(point, center, current_rotation)


func initialize_colonies_point():
	var x = -COLONIESMARGIN / 2.0
	var y = -COLONIESMARGIN / 2.0

	var column = 0
	while x < viewport_size.x + COLONIESMARGIN:
		while y < viewport_size.y + COLONIESMARGIN:
			colonies_point.append(Vector2(x, y))

			y += COLONIESMARGIN

		x += COLONIESMARGIN / 2.0

		column += 1
		if column % 2 == 0:
			y = -COLONIESMARGIN / 2.0
		else:
			y = -COLONIESMARGIN


func get_y_translation(x: float):
	return sin(0.25 * deg2rad(x))


func get_current_degree(x: float):
	return clamp(rad2deg(sin(0.5 * deg2rad(x))), -30, 30)


func _process(_delta):
	frames += 1

	update()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			show_mouse_position = true
			mouse_position = event.position

			$MouseLabel.rect_position = event.position
			$MouseLabel.text = "Speed : " + str(calculate_speed())
		elif event.button_index == BUTTON_LEFT and ! event.pressed:
			show_mouse_position = false

			current_speed = calculate_speed()

			$MouseLabel.text = ""
	elif event is InputEventMouseMotion and show_mouse_position:
		mouse_position = event.position

		$MouseLabel.rect_position = event.position
		$MouseLabel.text = "Speed : " + str(calculate_speed())


func calculate_speed() -> float:
	var L = sqrt(pow(center.x - mouse_position.x, 2) + pow(center.y - mouse_position.y, 2))

	return L / max_L * SPEED_MODIFIER


func calculate_rotation() -> float:
	return rad2deg(atan(center.x - mouse_position.x / center.y - mouse_position.y))
