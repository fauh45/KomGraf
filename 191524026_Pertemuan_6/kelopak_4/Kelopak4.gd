extends Shapes

const PADDING = 10

func _draw():
	var rx = 20
	var ry = 10
	
	var viewport_size = get_viewport().size
	var point = Vector2(rx * 2 + PADDING, rx * 2 + PADDING)
	
	while point.y < viewport_size.y - PADDING:
		while point.x < viewport_size.x - PADDING:
			draw_flower_4(rx, ry, point)
			
			point = Vector2(point.x + (rx * 4) + PADDING, point.y)
			
		point = Vector2(rx * 2 + PADDING, point.y + (rx * 4) + PADDING)

func _on_Button_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")
