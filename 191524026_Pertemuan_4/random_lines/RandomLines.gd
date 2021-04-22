extends Lines

const INITIAL_LINES = 10
var start_coordinates = PoolVector2Array()
var end_coordinates = PoolVector2Array()
var colors = PoolColorArray()


func get_random_coordinate() -> Vector2:
	var viewport_size: Vector2 = get_viewport().size
	randomize()

	var x = rand_range(0, viewport_size.x)
	var y = rand_range(0, viewport_size.y)

	return Vector2(x, y)


func get_random_color() -> Color:
	return Color(randf(), randf(), randf())


func _ready():
	for _i in range(INITIAL_LINES):
		start_coordinates.append(get_random_coordinate())
		end_coordinates.append(get_random_coordinate())
		colors.append(get_random_color())


func _draw():
	for i in range(start_coordinates.size()):
		draw_line_custom(start_coordinates[i], end_coordinates[i], colors[i])


func _on_HomeButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_Moar_pressed():
	start_coordinates.append(get_random_coordinate())
	end_coordinates.append(get_random_coordinate())
	colors.append(get_random_color())

	update()
