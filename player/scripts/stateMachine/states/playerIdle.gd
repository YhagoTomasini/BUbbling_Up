class_name PlayerIdle extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector2.ZERO

func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		emit_signal("finished", GROUND)
	elif Input.is_action_just_pressed("jump"):
		emit_signal("finished", AIR)

	
