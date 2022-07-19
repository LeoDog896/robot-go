extends KinematicBody

onready var body = get_tree().get_nodes_in_group("planet")

export var gravity = 10
export var speed = 4
export var rot_speed = 0.85

func generate_gravity() -> Vector3:
	return global_transform.origin * -1

var velocity = Vector3.ZERO

func _physics_process(delta):
	velocity += generate_gravity() * delta
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("backward"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("right"):
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("left"):
		rotate_y(rot_speed * delta)
	velocity.y = vy
