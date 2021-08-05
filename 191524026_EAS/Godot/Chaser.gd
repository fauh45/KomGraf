extends VehicleBody

const MAX_SPEED = 50

var should_move = false
var timer: Timer


func _ready():
	$ChaseCamera.current = false

	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(5)

	add_child(timer)
	timer.start()


func _physics_process(_delta):
	var player = get_parent().get_node("Player")

	if should_move:
		var enemy_to_player = flatten(player.translation - translation).normalized()
		var player_distance = translation.distance_to(player.translation)

		if player_distance <= 5:
			Global.status = Global.STATUS.LOSE

			get_tree().change_scene("res://Menu.tscn")

		player.get_node("TimeLeft").bbcode_text = (
			"[center][b]Chase is on![/b][/center][center]The chaser is "
			+ "%.2f" % player_distance
			+ "m away[/center][center]You got "
			+ "%.2f" % timer.time_left
			+ "s left[/center]"
		)

		var steer_degree = atan2(enemy_to_player.x, enemy_to_player.z)
		steering = clamp(steer_degree / 10, -0.35, 0.35)

		engine_force = clamp(MAX_SPEED * player_distance, 50, 100)
	else:
		player.get_node("TimeLeft").bbcode_text = (
			"[center][b]"
			+ "%.2f" % timer.time_left
			+ "s before chase![/b][/center]"
		)

		steering = 0
		engine_force = 0


func flatten(origin):
	return Vector3(origin.x, 0, origin.z)


func _on_timer_timeout():
	remove_child(timer)

	timer = Timer.new()
	timer.connect("timeout", self, "_on_win_timer_timeout")
	timer.set_wait_time(30)

	add_child(timer)
	timer.start()

	should_move = true


func _on_win_timer_timeout():
	Global.status = Global.STATUS.WIN

	get_tree().change_scene("res://Menu.tscn")
