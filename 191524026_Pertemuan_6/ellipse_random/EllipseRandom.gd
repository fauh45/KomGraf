extends Shapes

const N_ELLIPSE = 10

func _draw():
	var viewport_size = get_viewport().size
	
	for _i in range(N_ELLIPSE):
		var params = EllipseParams.new()
		params.randomize_quadrant_color()
		params.randomize_degree()
		
		randomize()
		var rx = rand_range(20, 200)
		var ry = rand_range(20, 200)
		
		randomize()
		var point = Vector2(rand_range(0, viewport_size.x - rx), rand_range(ry, viewport_size.y))
		
		draw_ellipse_midpoint(rx, ry, point, params)


func _on_Button_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")

func _on_Button2_pressed():
	update()
