class_name FloatComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = -40.0

var  isFalling: bool = false

func handleFloat(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
		
	isFalling = body.velocity.y > 0 and not body.is_on_floor()
