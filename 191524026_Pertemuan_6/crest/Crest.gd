extends Shapes

const RADIUS = 200
const PAD = 25

func _draw():
	var viewport_size = get_viewport().size
	var center = Vector2(viewport_size.x / 2, viewport_size.y / 2)
	var edge = Vector2(center.x - RADIUS + PAD, center.y)
	
	var triagle_len = 0.7 * RADIUS - PAD
	var left_triange_point = Utils.rotate(edge, center, -45)
	var right_triangle_point = Utils.translate(left_triange_point, Vector2(triagle_len + PAD, 0))
	
	
	draw_circle_midpoint(RADIUS, center, CircleParams.new())
	draw_triangle(left_triange_point, triagle_len)
	draw_triangle(right_triangle_point, triagle_len)
	draw_triangle(Utils.translate(center, Vector2(-(triagle_len / 2), 0)), triagle_len)


func _on_Button_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")
