extends Shapes

func _draw():
	draw_square(50, Vector2(100, 100), Color.blue)
	draw_square(50, Vector2(100, 175), Color.darkcyan, 5, 10, 10)
	
	draw_rectange(50, 25, Vector2(200, 100), Color.lightgray)
	draw_rectange(50, 25, Vector2(200, 175), Color.mediumaquamarine, 5, 10, 10)
	
	draw_parallelogram(50, 25, 50, Vector2(300, 100), Color.orange)
	draw_parallelogram(50, 25, 50, Vector2(300, 175), Color.mistyrose, 5, 10, 10)
	
	draw_rhombus(25, 50, Vector2(400, 100), Color.navajowhite)
	draw_rhombus(25, 50, Vector2(400, 175), Color.aliceblue, 5, 10, 10)
	
	draw_trapesium(25, 50, 25, Vector2(500, 100), Color.skyblue)
	draw_trapesium(25, 50, 25, Vector2(500, 175), Color.lightgray, 5, 10, 10)
	
	draw_triangle(50, 50, Vector2(600, 100), Color.moccasin)
	draw_triangle(50, 50, Vector2(600, 175), Color.lightgreen, 5, 10, 10)
	
func _on_HomeButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")
