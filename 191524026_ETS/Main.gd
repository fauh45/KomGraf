extends Fish

var frames = 0

var viewport_size: Vector2
var center: Vector2

var colonies_point: PoolVector2Array
var current_speed: float = 1.5
var current_rotation: float = 0
var current_zoom: float = 1.0

var mouse_position: Vector2
var show_mouse_position: bool = false

const SPEED_MODIFIER: float = 5.0
const MAX_ZOOM: float = 3.0
const MIN_ZOOM: float = 0.5

var max_L: float

var colonies_index_to_fly: int
var fly_frames: int

const FLY_SPEED: int = 2


func _draw():
	viewport_size = get_viewport_rect().size
	center = Vector2(viewport_size.x / 2, viewport_size.y / 2)

	max_L = center.x

	if frames == 0:
		colonies_point = []
		initialize_colonies_point()

	if frames % 400 == 0:
		set_new_flying_colonies()

	fly_frames += FLY_SPEED
	draw_colonies()
	draw_mouse_hint()


func set_new_flying_colonies():
	randomize()
	colonies_index_to_fly = int(floor(rand_range(0, colonies_point.size())))
	fly_frames = 0


func draw_colonies():
	var point_size = colonies_point.size()

	for i in range(point_size):
		colonies_point[i] = translate_point(colonies_point[i])

		if i == colonies_index_to_fly:
			draw_fish_colonies_fly(colonies_point[i], fly_frames, current_zoom)
			fly_frames += FLY_SPEED
		else:
			draw_fish_colonies(
				rotate_point(colonies_point[i]),
				get_current_degree(colonies_point[i].x),
				current_zoom,
				current_rotation
			)


func draw_mouse_hint():
	if show_mouse_position:
		draw_line(center, mouse_position, Color.white)


func translate_point(point: Vector2) -> Vector2:
	var y_translation = get_y_translation(point.x - current_speed)
	var new_point = Utils.translate(point, Vector2(-current_speed, y_translation))

	if new_point.x < -COLONIESMARGIN * current_zoom:
		new_point = Vector2(viewport_size.x + (COLONIESMARGIN * current_zoom), new_point.y)

	return new_point


func rotate_point(point: Vector2) -> Vector2:
	return Utils.rotate(point, center, current_rotation)


func initialize_colonies_point():
	var x = -COLONIESMARGIN / 2.0 * current_zoom
	var y = -COLONIESMARGIN / 2.0 * current_zoom

	var column = 0
	while x < viewport_size.x + COLONIESMARGIN * current_zoom:
		while y < viewport_size.y + COLONIESMARGIN * current_zoom:
			colonies_point.append(Vector2(x, y))

			y += COLONIESMARGIN * current_zoom

		x += COLONIESMARGIN / 2.0 * current_zoom

		column += 1
		if column % 2 == 0:
			y = -COLONIESMARGIN / 2.0 * current_zoom
		else:
			y = -COLONIESMARGIN * current_zoom


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
			$MouseLabel.text = (
				"Speed : "
				+ str(calculate_speed())
				+ "\nRotation : "
				+ str(calculate_rotation())
			)
		elif event.button_index == BUTTON_LEFT and ! event.pressed:
			show_mouse_position = false

			current_speed = calculate_speed()
			current_rotation = calculate_rotation()

			$MouseLabel.text = ""
		elif event.button_index == BUTTON_WHEEL_UP and event.pressed:
			current_zoom = clamp(current_zoom + 0.5, MIN_ZOOM, MAX_ZOOM)

			frames = 0
			update()
		elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			current_zoom = clamp(current_zoom - 0.5, MIN_ZOOM, MAX_ZOOM)

			frames = 0
			update()
	elif event is InputEventMouseMotion and show_mouse_position:
		mouse_position = event.position

		$MouseLabel.rect_position = event.position
		$MouseLabel.text = (
			"Speed : "
			+ str(calculate_speed())
			+ "\nRotation : "
			+ str(calculate_rotation())
		)
	elif event is InputEventKey:
		if event.scancode == KEY_W and not event.echo:
			current_rotation = 90
		elif event.scancode == KEY_D and not event.echo:
			current_rotation = 180
		elif event.scancode == KEY_S and not event.echo:
			current_rotation = 270
		elif event.scancode == KEY_A and not event.echo:
			current_rotation = 0


func calculate_speed() -> float:
	var L = sqrt(pow(center.x - mouse_position.x, 2) + pow(center.y - mouse_position.y, 2))

	return L / max_L * SPEED_MODIFIER


func calculate_rotation() -> float:
	var x = (center.x - mouse_position.x) if (center.x - mouse_position.x) != 0 else 0.001
	var y = center.y - mouse_position.y

	return rad2deg(atan(y / x))
