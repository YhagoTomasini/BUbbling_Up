extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") :
		finished.emit(WALKING)

func exit():
	pass
