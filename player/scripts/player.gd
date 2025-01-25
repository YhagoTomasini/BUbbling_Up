class_name PlayerCharacter extends CharacterBody2D

@export var jumpStrength = 300
@export var speed: float = 100
@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent

func _physics_process(delta: float) -> void:
	gravityComponent.handleGravity(self, delta)
	move_and_slide()
