extends CharacterBody2D
class_name Player

@export var gravity = 700
@export var speed = 125
var jump_force = 350

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
	if is_on_floor() == false:
		velocity.y += gravity * delta

	# Jump logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(jump_force)

	# Cap vertical velocity
	if velocity.y >= 500:
		velocity.y = 500

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

func jump(force):
	velocity.y = -force

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
