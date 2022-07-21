extends CPUParticles

func _process(delta):
	emitting = abs($"../back_left".engine_force) > 50
