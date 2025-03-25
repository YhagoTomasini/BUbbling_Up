extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	# Handle jump if carried over from Idle
	if data.has("jump") and data["jump"] and player.is_on_floor():
		player.is_jumping_from_idle = true

func physics_update(_delta: float) -> void:
	

	if not player.is_bouncing:
		player.velocity.x = get_input_velocity() * player.move_speed

		if (Input.is_action_just_pressed("jump") or player.is_jumping_from_idle) and player.is_on_floor():
			player.is_jumping_from_idle = false
			player.velocity.y = player.jump_velocity
			player.jump_sound.play()
		
		var direction = get_input_velocity()
		if direction:
			player.anim.scale.x = -1 if direction < 0 else 1
		elif player.is_on_floor() and player.velocity.x == 0 and player.velocity.y == 0:
			finished.emit(IDLE)

		if player.velocity.x != 0:
			player.anim.play("Walk")
		if player.velocity.y > 0:
			player.anim.play("Falling")
		elif player.velocity.y < 0:
			player.anim.play("Jump")

	## Apply continuous wind force
	#if player.wind_direction != 0:
		#player.velocity.x += player.wind_force * player.wind_direction * _delta


func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("left"):
		horizontal -= 1.0
	if Input.is_action_pressed("right"):
		horizontal += 1.0
	
	return horizontal

func exit():
	pass
