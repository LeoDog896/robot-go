extends Camera


onready var player = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	look_at_from_position(
		player.transform.origin + player.transform.origin.normalized() * 20,
		Vector3.ZERO, Vector3.UP
	)
