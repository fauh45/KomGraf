extends Node2D

var colors: Dictionary = {
	"yellow": Color("#ffeb3b"),
	"black": Color("#000000")
}

func _draw():
	# Face base
	draw_circle(Vector2(200, 200), 100, colors["yellow"])
	
	# Eyes
	draw_circle(Vector2(160, 175), 7, colors["black"])
	draw_circle(Vector2(240, 175), 7, colors["black"])
	
	# Smile!
	draw_arc(Vector2(200, 215), 55, deg2rad(0), 
	  deg2rad(180), 32, colors["black"], 3)
