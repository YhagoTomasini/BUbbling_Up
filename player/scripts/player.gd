class_name PlayerCharacter extends CharacterBody2D

var input_direction = Vector2.ZERO
@export var speed: float = 200
@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent

func _physics_process(delta: float) -> void:
	gravityComponent.handleGravity(self, delta)
	move_and_slide()
