extends Node2D


func _on_Button_pressed():
	get_tree().change_scene("res://triangle/Triangle.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://rhombus/Rhombus.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://ellipse_random/EllipseRandom.tscn")


func _on_Button4_pressed():
	get_tree().change_scene("res://kelopak_4/Kelopak4.tscn")


func _on_Button5_pressed():
	get_tree().change_scene("res://kelopak_8/Kelopak 8.tscn")


func _on_Button6_pressed():
	get_tree().change_scene("res://batik/Batik.tscn")


func _on_Button7_pressed():
	get_tree().change_scene("res://crest/Crest.tscn")
