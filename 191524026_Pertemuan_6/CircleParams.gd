class_name CircleParams

var octane_to_draw = []
var color_of_octane = PoolColorArray()


func _init(draw_octane: Array = [], octane_color: PoolColorArray = []):
	if draw_octane.size() < 8:
		initialize_octane_to_draw()
	else:
		octane_to_draw = draw_octane

	if octane_color.size() < 8:
		initialize_octene_color()
	else:
		color_of_octane = octane_color


func randomize_color():
	for i in range(8):
		randomize()
		color_of_octane[i] = Color(randf(), randf(), randf())


func change_all_color_to(color: Color):
	for i in range(8):
		octane_to_draw[i] = color


func initialize_octane_to_draw():
	for _i in range(8):
		octane_to_draw.append(true)


func initialize_octene_color():
	for _i in range(8):
		color_of_octane.append(Color.white)
