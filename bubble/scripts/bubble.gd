extends CharacterBody2D

@export_subgroup("Nodes")
@export var floatComponent: FloatComponent

@onready var anim = $Sprite2D
@onready var collider = $CollisionShape2D
@onready var collider2 = $Area2D/CollisionShape2D
@onready var timer = $Timer

func _ready() -> void:
	$Timer.start(1)
	anim.play("Bubbling")

func _physics_process(delta: float) -> void:
	floatComponent.handleFloat(self, delta)
	move_and_slide()

func _on_timer_timeout() -> void:
	anim.play("Popping")
	await get_tree().create_timer(0.5).timeout
	queue_free()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		anim.play("Popping") 
		await get_tree().create_timer(0.5).timeout
		queue_free()
