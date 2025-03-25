extends CharacterBody2D
class_name Player

@onready var jump_sound: AudioStreamPlayer = $jump_sound
#@onready var walk_sound: AudioStreamPlayer = $walk_sound

@export var jump_height : float = 75
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.4

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var is_jumping_from_idle: bool = false

@export var gravity = 700

@export var move_speed = 150.0

var is_bouncing: bool = false
var bounce_timer = 0.0  # Timer to track bounce delay
var bounce_duration = 0.2  # Duration of the bounce effect

var wind_force = 0
var wind_direction = 0

var max_speed: float = 400

@onready var anim = $Sprite2D

func _physics_process(delta):
	# Handle bounce timer
	if is_bouncing:
		bounce_timer -= delta
		if bounce_timer <= 0:
			is_bouncing = false

	else:
		if not is_on_floor():
			velocity.y += gravity * delta

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bubble"):
		is_bouncing = true
		bounce_timer = bounce_duration  # Set the bounce timer duration
		var normal = (position - area.global_position).normalized()
		velocity = velocity.bounce(normal) * 3  # Adjust the multiplier for bounce strength
		velocity = velocity.limit_length(max_speed)

	if area.is_in_group("wind"):
		var is_wind_left = area.get("is_wind_left")
		wind_direction = 1 if is_wind_left else -1
		wind_force = 1000

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("wind"):
		wind_direction = 0
		wind_force = 0
