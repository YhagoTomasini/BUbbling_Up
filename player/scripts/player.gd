extends CharacterBody2D
class_name Player

@export var gravity = 700
@export var speed = 125
var jump_force: float = 150
var jump_hold: bool = false

var max_jump_height: float = 50
var jump_start_y: float = 0
var is_jumping: bool = false

var friction = 800

var wind_force = 0
var wind_direction = 0

func _physics_process(delta):
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_pressed("jump") and is_jumping and jump_hold:
		# Stop jumping if maximum height is reached
		if position.y <= jump_start_y - max_jump_height:
			jump_hold = false
		else:
			velocity.y = -jump_force

	# Allow the jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
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
		# Calculate the bounce direction
		var normal = (position - area.global_position).normalized()
		velocity = velocity.bounce(normal) * 3.5  # Adjust the multiplier for bounce strength

		
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("wind"):
		wind_direction = 0
		wind_force = 0
