extends Shapes

const DEG_30 = 0.7
const SMILEY_BASE_WIDTH = 120


func _draw():
	var viewport_size = get_viewport().size

	randomize()
	var scale: float = rand_range(0.2, 2)
	var width_padding = scale * SMILEY_BASE_WIDTH
	var center_point = Vector2(
		rand_range(0, viewport_size.x - width_padding),
		rand_range(0, viewport_size.y - width_padding)
	)

	draw_smiley(center_point, scale)


func draw_smiley(center_point: Vector2, scale: float):
	draw_smiley_mouth(center_point, scale)
	draw_smiley_outer_ring(center_point, scale)
	draw_smiley_eye_and_nose(center_point, scale)


func draw_smiley_eye_and_nose(center_point: Vector2, scale: float):
	var radius = 30 * scale

	var scaled_add = 25 * scale
	var x_seperation = radius / 2 + scaled_add
	var y = center_point.y - radius / 2 - scaled_add

	var params_1 = CircleParams.new()
	params_1.randomize_color()

	var params_2 = CircleParams.new()
	params_2.randomize_color()

	draw_circle_midpoint(radius, Vector2(center_point.x - x_seperation, y), params_1)
	draw_circle_midpoint(radius, Vector2(center_point.x + x_seperation, y), params_2)

	draw_line_custom(
		Vector2(center_point.x, y),
		Vector2(center_point.x, center_point.y + scaled_add),
		Color(randf(), randf(), randf()),
		5 * scale,
		true,
		5 * scale,
		5 * scale
	)


func draw_smiley_outer_ring(center_point: Vector2, scale: float):
	var params = CircleParams.new()
	params.randomize_color()

	draw_circle_midpoint(SMILEY_BASE_WIDTH * scale, center_point, params)


func draw_smiley_mouth(center_point: Vector2, scale: float):
	var params = config_draw_only([0, 7])
	params.randomize_color()

	var radius = 100 * scale

	var x_diff = DEG_30 * radius
	var y = center_point.y + (0.7 * radius)

	draw_circle_midpoint(radius, center_point, params)
	draw_line_custom(
		Vector2(center_point.x - x_diff, y),
		Vector2(center_point.x + x_diff, y),
		Color(randf(), randf(), randf())
	)


func _on_HomeButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_Randomize_pressed():
	update()
