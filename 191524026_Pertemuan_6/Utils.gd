static func translate(start: Vector2, amount: Vector2) -> Vector2:
	return Vector2(start.x + amount.x, start.y + amount.y)

static func rotate(point: Vector2, anchor: Vector2, degree: float) -> Vector2:
	var rot_cos = cos(deg2rad(degree))
	var rot_sin = sin(deg2rad(degree))
	
	return Vector2(
		anchor.x + ((point.x - anchor.x) * rot_cos) - ((point.y - anchor.y) * rot_sin),
		anchor.y + ((point.x - anchor.x) * rot_sin) + ((point.y - anchor.y) * rot_cos)
	)
