extends CharacterBody2D

@export_subgroup("Nodes")
@export var floatComponent: FloatComponent

@onready var timer = $Timer
@onready var bounce_timer = $"../BounceTimer"

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
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		# Calculate and apply the bounce direction
		var normal = (area.global_position - global_position).normalized()
		velocity = velocity.bounce(normal) * 1.5  # Adjust bounce multiplier as needed

		# Start the bounce timer for delayed removal
		bounce_timer.start()

	if area.is_in_group("wind"):
		var is_wind_left = area.get("is_wind_left") 
		wind_direction = 1 if is_wind_left else -1
		wind_force = 500  

func _on_bounce_timer_timeout() -> void:
	queue_free()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("wind"):
		wind_direction = 0
		wind_force = 0
