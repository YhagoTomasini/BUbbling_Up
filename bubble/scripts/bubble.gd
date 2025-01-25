extends CharacterBody2D

@export_subgroup("Nodes")
@export var floatComponent: FloatComponent

func _physics_process(delta: float) -> void:
	floatComponent.handleFloat(self, delta)
	
	move_and_slide()
