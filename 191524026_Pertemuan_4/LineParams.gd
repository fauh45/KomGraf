var start: Vector2
var end: Vector2
var color: Color
var thickness: float
var dotted: bool
var dash: int
var gap: int


func _init(
	va: Vector2,
	vb: Vector2,
	_line_color: Color,
	_thickness: float = 1,
	_dotted: bool = false,
	_dash: int = 1,
	_gap: int = 0
):
	start = va
	end = vb
	color = _line_color
	thickness = _thickness
	dotted = _dotted
	dash = _dash
	gap = _gap
