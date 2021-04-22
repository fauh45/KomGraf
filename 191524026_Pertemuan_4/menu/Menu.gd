extends Node2D


func _on_RandomLinesButton_pressed():
	get_tree().change_scene("res://random_lines/RandomLines.tscn")


func _on_LineGenerationButton2_pressed():
	get_tree().change_scene("res://line_generation/LineGen.tscn")


func _on_ShapeButton_pressed():
	get_tree().change_scene("res://shape/Shape.tscn")
