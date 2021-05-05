class_name EllipseParams

var quadrant_to_draw = []
var quadrant_color = PoolColorArray()
var degree: float

func _init(_quadrant_to_draw: Array = [], _quadrant_color: PoolColorArray = [], _degree: float = 0):
	if _quadrant_color.size() < 4:
		initialize_quadrant_color()
	else:
		quadrant_color = _quadrant_color
	
	if _quadrant_to_draw.size() < 4:
		initialize_quadrant_to_draw()
	else:
		quadrant_to_draw = _quadrant_to_draw
	
	degree = _degree


func initialize_quadrant_color():
	for _i in range(4):
		quadrant_color.append(Color.white)


func initialize_quadrant_to_draw():
	for _i in range(4):
		quadrant_to_draw.append(true)


func randomize_quadrant_color():
	for i in range(4):
		randomize()
		quadrant_color[i] = Color(randf(), randf(), randf())


func set_degree(_degree: float):
	degree = _degree


func randomize_degree():
	randomize()
	degree = rand_range(0, 360)
