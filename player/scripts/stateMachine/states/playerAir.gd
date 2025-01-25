class_name PlayerAir extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	pass

func handle_input(event: InputEvent) -> void:
	pass

func physics_update(delta: float) -> void:
	if player.isJumping:
		player.velocity.y -= player.jumpStrength
	if player.is_on_floor():
		player.isJumping = false
		emit_signal("finished", GROUND)
	player.move_and_slide()
#
