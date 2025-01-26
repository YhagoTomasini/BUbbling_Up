extends CharacterBody2D
class_name Player

@export var gravity = 700
@export var speed = 125
var jump_force: float = 150
var jump_hold: bool = false

var max_jump_height: float = 50 
var jump_start_y: float = 0 
var is_jumping: bool = false #

var friction = 800

var is_knocked_back = false
var knockback_time = 0.3
var knockback_timer = 0.0

var is_recovering = false
var recovery_time = 0.05
var recovery_timer = 0.0

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

	## Cap vertical velocity
	#if velocity.y >= 500:
		#velocity.y = 500

	# Handle knockback
	if is_knocked_back:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false
			is_recovering = true
			recovery_timer = recovery_time
	elif is_recovering:
		recovery_timer -= delta
		if recovery_timer <= 0:
			is_recovering = false
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
		var force_direction = sign(velocity.x) * -1
		velocity.x = 300 * force_direction
		velocity.y = -300
		is_knocked_back = true
		knockback_timer = knockback_time

	if area.is_in_group("wind"):
		var is_wind_left = area.get("is_wind_left")
		wind_direction = 1 if is_wind_left else -1
		wind_force = 1000  

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("wind"):
		wind_direction = 0
		wind_force = 0
