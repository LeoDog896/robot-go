extends Camera

onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	transform.origin = player.transform.origin * 2
	look_at(player.transform.origin, Vector3.UP)

func _process(delta):
	transform.origin = player.transform.origin * 2
	look_at(player.transform.origin, Vector3.UP)
