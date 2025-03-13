extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	# Handle bounce timer
	if player.is_bouncing:
		player.bounce_timer -= _delta
		if player.bounce_timer <= 0:
			player.is_bouncing = false

	if not player.is_bouncing:
		# Apply gravity if not on the floor
		#if not player.is_on_floor():
			#player.velocity.y += player.gravity * _delta

		if player.velocity.x != 0:
			player.anim.play("Walk")
		if player.velocity.y > 0:
			player.anim.play("Falling")
		elif player.velocity.y < 0:
			player.anim.play("Jump")
			
		# Handle jump
		if Input.is_action_pressed("jump") and player.is_jumping and player.jump_hold:
			
			# Stop jumping if maximum height is reached
			if player.position.y <= player.jump_start_y - player.max_jump_height:
				player.jump_hold = false
			else:
				player.velocity.y = -player.jump_force

		# Allow the jump
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			player.jump_sound.play()
			player.velocity.y = -player.jump_force
			player.jump_hold = true
			player.is_jumping = true
			player.jump_start_y = player.position.y

		else:
			# Player movement
			var direction = Input.get_axis("left", "right")
			if direction != 0:
				player.velocity.x = direction * player.speed
			elif player.is_on_floor():
				player.velocity.x = move_toward(player.velocity.x, 0, player.friction * _delta)
			if direction:
				player.anim.scale.x = -1 if direction < 0 else 1
			elif player.is_on_floor():
				player.anim.play("Idle")

	# Apply continuous wind force
	if player.wind_direction != 0:
		player.velocity.x += player.wind_force * player.wind_direction * _delta

	player.move_and_slide()

func exit():
	pass
