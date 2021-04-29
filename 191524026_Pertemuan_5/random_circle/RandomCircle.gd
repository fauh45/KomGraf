extends Shapes


const NUM_CIRCLES = 15

func _draw():
	var viewport_size = get_viewport().size
	
	for _i in range(NUM_CIRCLES):
		randomize()
		
		var params = CircleParams.new()
		params.randomize_color()

		draw_circle_midpoint(
			rand_range(5, 150),
			Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y)),
			params
		)


func _on_HomeButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_Randomize_pressed():
	update()
