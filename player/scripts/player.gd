extends CharacterBody2D
class_name Player

@export var gravity = 500
@export var speed = 100
var jump_force = 250

var is_knocked_back = false
var knockback_time = 0.3
var knockback_timer = 0.0

var is_recovering = false
var recovery_time = 0.05
var recovery_timer = 0.0

@onready var anim = $Sprite2D

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
	
	elif velocity.x != 0:
		anim.play("Walk")
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		jump(jump_force)
		
	if velocity.y >= 500:
		velocity.y = 500
	
	if velocity.y > 0:
		anim.play("Falling")
	elif velocity.y < 0:
		anim.play("Jump")
	
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
		var direction = Input.get_axis("left", "right")
		velocity.x = direction  * speed
		
		if direction:
			anim.scale.x = -1 if direction < 0 else 1
		elif is_on_floor() == true:
			anim.play("Idle")
	
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
