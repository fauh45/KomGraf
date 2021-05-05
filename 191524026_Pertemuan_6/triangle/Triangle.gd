extends Shapes


func _draw():
	var viewport_size = get_viewport().size
	
	randomize()
	var size = rand_range(60, 250)
	var point = Vector2(rand_range(0, viewport_size.x - size), rand_range(size, viewport_size.y))
	
	while size - 50 > 0:
		randomize()
		draw_triangle(point, size, Color(randf(), randf(), randf()))
		
		point = Utils.translate(point, Vector2(5, -5))
		size -= 10


func _on_Button_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_Button2_pressed():
	update()
