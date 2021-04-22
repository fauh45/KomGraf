extends Lines

var line_to_draw = Array()

var start_coor: Vector2
var end_coor: Vector2


func _ready():
	var viewport_size = get_viewport().size
	var center_x = viewport_size.x / 2
	var center_y = viewport_size.y / 2

	line_to_draw.append(
		LineParams.new(
			Vector2(center_x - 150, center_y - 150),
			Vector2(center_x + 150, center_y - 150),
			Color.white,
			3
		)
	)
	line_to_draw.append(
		LineParams.new(
			Vector2(center_x - 150, center_y - 125),
			Vector2(center_x + 150, center_y - 125),
			Color.blue
		)
	)
	line_to_draw.append(
		LineParams.new(
			Vector2(center_x - 150, center_y - 100),
			Vector2(center_x + 150, center_y - 100),
			Color.green,
			1,
			true,
			10,
			10
		)
	)
	line_to_draw.append(
		LineParams.new(
			Vector2(center_x - 150, center_y - 75),
			Vector2(center_x + 150, center_y - 75),
			Color.aqua,
			10
		)
	)
	line_to_draw.append(
		LineParams.new(
			Vector2(center_x - 150, center_y - 50),
			Vector2(center_x + 150, center_y - 50),
			Color.green,
			1,
			true,
			10,
			3
		)
	)

	$DrawLabel.text = "Click to start drawing!"


func _draw():
	for params in line_to_draw:
		draw_line_from_params(params)


func add_from_input():
	line_to_draw.append(
		LineParams.new(
			start_coor,
			end_coor,
			Color(randf(), randf(), randf()),
			$Thickness.value,
			$Gap.value > 1 and $Dash.value > 1,
			$Dash.value,
			$Gap.value
		)
	)

	update()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			start_coor = event.position
			$DrawLabel.text = "Release to draw!"
		elif event.button_index == BUTTON_LEFT and not event.pressed:
			end_coor = event.position
			$DrawLabel.text = "Click to start drawing!"

			add_from_input()


func _on_HomeButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")
