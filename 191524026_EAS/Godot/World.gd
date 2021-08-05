extends Spatial


func _input(event):
	if event.is_action_pressed("change_camera"):
		if $Player/BackCamera.current:
			$Chaser/ChaseCamera.current = true
		else:
			$Player/BackCamera.current = true
