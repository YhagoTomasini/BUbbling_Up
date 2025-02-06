extends CharacterBody2D
class_name Player

@onready var jump_sound: AudioStreamPlayer = $jump_sound
#@onready var walk_sound: AudioStreamPlayer = $walk_sound


@export var gravity = 700
@export var speed = 150
var jump_force: float = 200
var jump_hold: bool = false

var max_jump_height: float = 50
var jump_start_y: float = 0
var is_jumping: bool = false
var is_bouncing: bool = false
var friction = 800

var wind_force = 0
var wind_direction = 0

var bounce_timer = 0.0  # Timer to track bounce delay
var bounce_duration = 0.2  # Duration of the bounce effect

var max_speed = 400

@onready var anim = $Sprite2D

func _physics_process(delta):
	# Handle bounce timer
	if is_bouncing:
		bounce_timer -= delta
		if bounce_timer <= 0:
			is_bouncing = false

	if not is_bouncing:
		# Apply gravity if not on the floor
		if not is_on_floor():
			velocity.y += gravity * delta

		elif velocity.x != 0:
			anim.play("Walk")
		if velocity.y > 0:
			anim.play("Falling")
		elif velocity.y < 0:
			anim.play("Jump")
			
		# Handle jump
		if Input.is_action_pressed("jump") and is_jumping and jump_hold:
			
			# Stop jumping if maximum height is reached
			if position.y <= jump_start_y - max_jump_height:
				jump_hold = false
			else:
				velocity.y = -jump_force

		# Allow the jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump_sound.play()
			velocity.y = -jump_force
			jump_hold = true
			is_jumping = true
			jump_start_y = position.y

		else:
			# Player movement
			var direction = Input.get_axis("left", "right")
			if direction != 0:
				velocity.x = direction * speed
			elif is_on_floor():
				velocity.x = move_toward(velocity.x, 0, friction * delta)
			if direction:
				anim.scale.x = -1 if direction < 0 else 1
			elif is_on_floor():
				anim.play("Idle")

	# Apply continuous wind force
	if wind_direction != 0:
		velocity.x += wind_force * wind_direction * delta

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("jump"):
		jump_hold = false
		is_jumping = false

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
