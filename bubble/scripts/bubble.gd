extends CharacterBody2D

@export_subgroup("Nodes")
@export var floatComponent: FloatComponent

@onready var timer: Timer = $Timer
@export var bounce_strength: float = 3
@onready var sprite: AnimatedSprite2D = $Sprite2D



@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var puff: AudioStreamPlayer = $puff



var wind_force = 0  
var wind_direction = 0  

func _ready() -> void:
	$Timer.start(1)


func _physics_process(delta: float) -> void:
	floatComponent.handleFloat(self, delta)

	if wind_direction != 0:
		velocity.x += wind_force * wind_direction * delta

	move_and_slide()

func _on_timer_timeout() -> void:
	sprite_2d.play("Popping")
	puff.play()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		sprite_2d.play("Popping")
		puff.play()
		
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("wind"):
		wind_direction = 0
		wind_force = 0


func _on_sprite_2d_animation_finished() -> void:
	
	queue_free()
