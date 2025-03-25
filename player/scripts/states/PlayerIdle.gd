extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.anim.play("Idle")
	
	var jump_pressed = Input.is_action_just_pressed("jump")
	var moving = Input.is_action_pressed("left") or Input.is_action_pressed("right")

	if jump_pressed or moving:
		finished.emit(MOVING, {"jump": jump_pressed})  # Pass jump info


func exit():
	pass
