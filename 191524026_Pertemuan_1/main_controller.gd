extends Node2D

func _ready():
	$Point.hide()
	$Emots.hide()
	$Bingkai.hide()

func _on_EmotButton_pressed():
	$Menu.get_child(0).hide()
	$Emots.show()


func _on_EmotsBackButton_pressed():
	$Emots.hide()
	$Menu.get_child(0).show()


func _on_PointBackButton_pressed():
	$Point.hide()
	$Menu.get_child(0).show()


func _on_PointButton_pressed():
	$Point.show()
	$Menu.get_child(0).hide()


func _on_BingkaiButton_pressed():
	$Bingkai.show()
	$Menu.get_child(0).hide()


func _on_PointBackButton2_pressed():
	$Bingkai.hide()
	$Menu.get_child(0).show()
