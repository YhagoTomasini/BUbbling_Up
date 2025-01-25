class_name PlayerWalk extends PlayerState

func enter() -> void:
	player.animation_state_machine.set_anim(player.animations.WALK)

func physics_update(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right")
	if (input_direction == Vector2.ZERO):
		transition.emit(self, IDLE)
	else:
		player.input_direction = input_direction
		if (player.animations):
			player.animation_state_machine.update_blendspaces(player.input_direction)
		player.target_move_vector = player.input_direction.normalized() * player.move_speed
		player.current_move_vector = player.target_move_vector.lerp(player.current_move_vector, 0.5 ** (player.MOVE_SMOOTH_FACTOR * delta))
		player.velocity = player.current_move_vector
		if player.secondary_velocity.length() > 0:
			player.velocity += player.secondary_velocity
		
		player.velocity = Util.vec2_scale_y(player.velocity, 0.71)
		player.move_and_slide()
		if Input.is_action_just_pressed("jump") && player.jump_regen >= player.dash_cooldown:
			transition.emit(self, JUMP)
