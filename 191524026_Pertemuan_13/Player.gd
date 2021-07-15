extends VehicleBody

const MAX_STEER_ANGLE = 0.35
const STEER_SPEED = 1

const MAX_ENGINE_FORCE = 175
const MAX_BRAKE_FORCE = 10
const MAX_SPEED = 200

var steer_target = 0.0
var steer_angle = 0.0

func _ready():
	$CameraOnBoard.current = true

func _physics_process(delta):
	drive(delta)

func drive(delta):
	steering=apply_steering(delta)
	engine_force= apply_throttle()
	brake = apply_brake()

func apply_steering(delta):
	var steer_val=0
	var kiri = Input.get_action_strength("car_left")
	var kanan = Input.get_action_strength("car_right")
	
	if kiri:
		steer_val = kiri
	elif kanan:
		steer_val = -kanan
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if steer_target < steer_angle:
		steer_angle -= STEER_SPEED * delta
	elif steer_target > steer_angle:
		steer_angle += STEER_SPEED * delta
		
	return steer_angle
	
func apply_throttle():
	var throttle_val = 0
	var maju = Input.get_action_strength("car_front")
	var mundur = Input.get_action_strength("car_backwards")
	
	if mundur:
		throttle_val = -mundur
	elif maju:
		throttle_val = maju
	
	return throttle_val * MAX_ENGINE_FORCE

func apply_brake():
	var brake_val = 0
	var brake_strength = Input.get_action_strength("car_brake")
	
	if brake_strength:
		brake_val = brake_strength
		
	return brake_val * MAX_BRAKE_FORCE

func _process(delta):
	if Input.is_action_just_released("car_change_camera"):
		if $CameraOnBoard.current:
			$CameraOutBoard.make_current()
		else:
			$CameraOnBoard.make_current()
