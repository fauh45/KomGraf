extends Shapes

const DEG_30 = 0.7


func _draw():
	var viewport_size = get_viewport().size
	var center_point = Vector2(viewport_size.x / 2, viewport_size.y / 2)

	var radius = 200
	var params = config_draw_only([4, 3, 2, 1, 0, 7])
	draw_circle_midpoint(radius, center_point, params)

	var diff = DEG_30 * radius
	var length = diff * 2
	var top_left_square = Vector2(center_point.x - length, center_point.y - diff)
	draw_square(length, top_left_square, Color.white)
	
	# boundary_fill(top_left_square, Color.white, Color(198, 66, 32))

	draw_line_custom(center_point, Vector2(center_point.x, center_point.y - radius), Color.white)
	draw_line_custom(center_point, Vector2(center_point.x + radius, center_point.y), Color.white)

	var square_center = Vector2(top_left_square.x + diff, top_left_square.y + diff)
	var p_width = 0.3 * length
	var p_height = p_width * 2

	var p_x = square_center.x - p_width / 2
	var p_y_delta = p_height / 2
	draw_line_custom(
		Vector2(p_x, square_center.y - p_y_delta),
		Vector2(p_x, square_center.y + p_y_delta),
		Color.white
	)

	draw_line_custom(Vector2(p_x, square_center.y), square_center, Color.white)
	draw_line_custom(
		Vector2(p_x, square_center.y - p_y_delta),
		Vector2(square_center.x, square_center.y - p_y_delta),
		Color.white
	)
	var half_circle_params = config_draw_only([3, 2, 1, 0])
	draw_circle_midpoint(
		p_y_delta / 2, Vector2(square_center.x, square_center.y - p_y_delta / 2), half_circle_params
	)


func _on_HomeButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")
