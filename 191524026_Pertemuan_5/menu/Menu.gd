extends Node2D


func _on_RandomCircleButton_pressed():
	get_tree().change_scene("res://random_circle/RandomCircle.tscn")


func _on_SmileyButton_pressed():
	get_tree().change_scene("res://smiley/Smiley.tscn")


func _on_Logo_pressed():
	get_tree().change_scene("res://logo/Logo.tscn")
