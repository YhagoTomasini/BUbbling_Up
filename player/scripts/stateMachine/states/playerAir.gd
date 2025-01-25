class_name PlayerAir extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.jumpStrength

func handle_input(event: InputEvent) -> void:
	pass

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		emit_signal("finished", GROUND)
	player.move_and_slide()
