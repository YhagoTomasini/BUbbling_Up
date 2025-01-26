extends CharacterBody2D

@export_subgroup("Nodes")
@export var floatComponent: FloatComponent

@onready var timer = $Timer

func _ready() -> void:
	$Timer.start(1)

func _physics_process(delta: float) -> void:
	floatComponent.handleFloat(self, delta)
	move_and_slide()

func _on_timer_timeout() -> void:
	queue_free()
