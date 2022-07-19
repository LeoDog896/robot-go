extends RigidBody

var local_gravity = Vector3.DOWN
export (float) var rotation_speed = 10
export (float) var move_speed = 10

var _move_direction := Vector3.ZERO
var _last_strong_direction := _move_direction

func _integrate_forces(state) -> void:
	
	local_gravity = state.total_gravity.normalized()
	
	if _move_direction.length() > 0.2:
		_last_strong_direction = _move_direction.normalized()
	
	_move_direction = _get_oriented_input()
	_orient_to_direction(_last_strong_direction, state.step)
	
	add_central_force(_move_direction * move_speed)
	linear_velocity = state.linear_velocity
	
func _get_oriented_input() -> Vector3:
	var input_left_right := (
		Input.get_action_strength("right") - Input.get_action_strength("left")
	)
	
	var input_forward_backward := (
		Input.get_action_raw_strength("forward") - Input.get_action_strength("backward")
	)
	
	
	var raw_input = Vector2(input_left_right, input_forward_backward)
	
	var input := Vector3.ZERO
	
	input.x = raw_input.x * sqrt(1.0 - raw_input.y * raw_input.y / 2.0)
	input.z = raw_input.y * sqrt(1.0 - raw_input.x * raw_input.x / 2.0)

	input = transform.basis.xform(input)
	return input

func _orient_to_direction(direction: Vector3, delta: float) -> void:
	var left_axis = -local_gravity.cross(direction)
	var rotation_basis := Basis(left_axis, -local_gravity, direction).orthonormalized()
	transform.basis = transform.basis.get_rotation_quat().slerp(
		rotation_basis, delta * rotation_speed
	)
