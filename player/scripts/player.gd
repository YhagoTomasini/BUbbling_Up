extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent

func _physics_process(delta: float) -> void:
	gravityComponent.handleGravity(self, delta)
	
	move_and_slide()
