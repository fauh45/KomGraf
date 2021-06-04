extends Shapes

class_name Fish

const SIN45 = sin(deg2rad(45))
const BODYTOTAILRATIO: float = 0.125
const BODYTOEYERATIO: float = 0.03125
const COLONIESMARGIN: float = 280.0
const MAX_FLY_FRAMES: int = 90

var MARGINUNIT: float = 10.0


func draw_fish_colonies(
	center_point: Vector2,
	rotation: float = 0,
	zoom_level: float = 1.0,
	colonies_rotation: float = 1.0
):
	draw_fish(
		Utils.rotate(
			Vector2(center_point.x, center_point.y + (70 * zoom_level)),
			center_point,
			colonies_rotation
		),
		Color.brown,
		100 * zoom_level,
		rotation + colonies_rotation
	)
	draw_fish(
		Utils.rotate(
			Vector2(center_point.x, center_point.y - (70 * zoom_level)),
			center_point,
			colonies_rotation
		),
		Color.teal,
		100 * zoom_level,
		rotation + colonies_rotation
	)
	draw_fish(center_point, Color.black, 100 * zoom_level, rotation + colonies_rotation)


func draw_fish_colonies_fly(center_point: Vector2, frames: int, zoom_level: float = 1.0):
	if frames > MAX_FLY_FRAMES:
		return

	draw_fish_colonies(
		Utils.translate(center_point, Vector2(0, -get_fly_y_translation(frames))),
		0,
		get_fly_zoom(zoom_level, frames),
		get_fly_rotation(frames)
	)


func get_fly_rotation(frame: int) -> float:
	return rad2deg(-tan(deg2rad(float(frame) / 10)) + 3.5) - 90


func get_fly_y_translation(frame: int) -> float:
	return tan(deg2rad(frame)) + 3.5


func get_fly_zoom(zoom_level: float, frames: int) -> float:
	var normalized_frames = clamp(float(frames) / 20, 1, float(MAX_FLY_FRAMES) / 20)
	return zoom_level / normalized_frames


func draw_fish(center_point: Vector2, color: Color, length: float, rotation: float = 0):
	MARGINUNIT = length / 15
	var radius: float = length / (2 * SIN45)

	draw_fish_body(center_point, color, radius, rotation)
	draw_fish_tail(center_point, color, length, radius, rotation)
	draw_fish_eye(center_point, color, length, rotation)


func draw_fish_body(center_point: Vector2, color: Color, radius: float, rotation: float):
	var delta_r = radius * SIN45

	var upper_middle_point = Vector2(center_point.x, center_point.y - delta_r)
	var lower_middle_point = Vector2(center_point.x, center_point.y + delta_r)

	var params_upper = config_draw_only([0, 7])
	params_upper.set_color_to_all(color)
	params_upper.set_width(2.0)
	params_upper.set_rotation(rotation, center_point)

	var params_lower = config_draw_only([3, 4])
	params_lower.set_color_to_all(color)
	params_lower.set_width(2.0)
	params_lower.set_rotation(rotation, center_point)

	draw_circle_midpoint(radius, upper_middle_point, params_upper)
	draw_circle_midpoint(radius, lower_middle_point, params_lower)


func draw_fish_tail(
	center_point: Vector2, color: Color, length: float, radius: float, rotation: float
):
	var fish_height = (2 * radius - length) / 2 - MARGINUNIT / 2
	var tail_length = length * BODYTOTAILRATIO

	var start_point = Vector2(center_point.x + length / 2, center_point.y)
	var rotated_start_point = Utils.rotate(start_point, center_point, rotation)

	draw_polyline(
		[
			rotated_start_point,
			Utils.rotate(
				Vector2(start_point.x + tail_length, start_point.y + fish_height),
				center_point,
				rotation
			),
			Utils.rotate(
				Vector2(start_point.x + tail_length, start_point.y - fish_height),
				center_point,
				rotation
			),
			rotated_start_point
		],
		color,
		2.0,
		true
	)


func draw_fish_eye(center_point: Vector2, color: Color, length: float, rotation: float):
	var eye_center = Utils.rotate(
		Vector2(center_point.x - length / 2 + 3 * MARGINUNIT, center_point.y),
		center_point,
		rotation
	)

	draw_circle(eye_center, length * BODYTOEYERATIO, color)
