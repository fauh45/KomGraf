extends Node2D


func _ready():
	if Global.status == Global.STATUS.WIN:
		$Label.text = "Congratulations! You won!"
	elif Global.status == Global.STATUS.LOSE:
		$Label.text = "You lose! Try Again?"

	if Global.status != Global.STATUS.START:
		$Button/Label.text = "Try Again?"


func _on_Button_pressed():
	Global.status = Global.STATUS.START

	get_tree().change_scene("res://World.tscn")
