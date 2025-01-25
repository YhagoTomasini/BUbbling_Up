class_name PlayerCharacter extends CharacterBody2D

@export var jumpStrength = 300
@export var speed: float = 100
@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent
var isJumping: bool = false


	
func _process(delta):
	if(Input.is_action_pressed("jump")):
		isJumping = true
	else:
		isJumping = false
	print(isJumping)

func _physics_process(delta: float) -> void:
	gravityComponent.handleGravity(self, delta)
	move_and_slide()
