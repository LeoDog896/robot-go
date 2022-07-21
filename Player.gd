extends VehicleBody

export var max_rpm = 500
export var max_torque = 200
export var speed = 3

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("left", "right") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("forward", "backward") * speed
	var rpm_left = $back_left.get_rpm()
	$back_left.engine_force = acceleration * max_torque * (1 - rpm_left / max_rpm)
	var rpm_right = $back_right.get_rpm()
	$back_right.engine_force = acceleration * max_torque * (1 - rpm_right / max_rpm)
