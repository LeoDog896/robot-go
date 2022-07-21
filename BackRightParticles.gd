extends CPUParticles

func _process(delta):
	emitting = abs($"../back_right".engine_force) > 50
