extends CharacterBody2D
class_name Player

@export var gravity = 500
@export var speed = 100
var jump_force = 250

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
