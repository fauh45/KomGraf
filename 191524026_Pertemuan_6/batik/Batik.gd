extends Shapes

const NUM_EACH_CLOVE = 25

func _draw():
	var viewpor_size = get_viewport().size
	
	for i in range(NUM_EACH_CLOVE * 2):
		var rx = rand_range(10, 40)
		var ry = rx / 2
		
		var point = Vector2(rand_range(rx * 4, viewpor_size.x - rx * 4), rand_range(rx * 4, viewpor_size.y - rx * 4))
		if i % 2 == 0:
			draw_flower_4(rx, ry, point)
		else:
			draw_flower_8(rx, ry, point)


func _on_Button_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_Button2_pressed():
	update()
