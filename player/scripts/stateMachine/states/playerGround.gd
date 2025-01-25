class_name PlayergROUND extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	pass

func handle_input(event: InputEvent) -> void:
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		emit_signal("finished", IDLE)
	elif Input.is_action_just_pressed("jump"):
		emit_signal("finished", AIR)

func physics_update(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("left"):
		direction -= 1	
	if Input.is_action_pressed("right"):
		direction += 1

	player.velocity.x = direction * player.speed
	player.move_and_slide()
