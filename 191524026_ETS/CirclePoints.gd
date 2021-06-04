class_name CirclePoints

var temp_points = []
var circle_params: CircleParams


func _init(params: CircleParams):
	circle_params = params

	for _i in range(8):
		temp_points.append([])


func add_point_to_octane(octane_number: int, point: Vector2):
	temp_points[octane_number].append(
		Utils.rotate(point, circle_params.rotation_center, circle_params.rotation)
	)
