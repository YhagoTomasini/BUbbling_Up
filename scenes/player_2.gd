extends AnimatedSprite2D

#@onready var bolha_aparece: AudioStreamPlayer = $bolha_aparece


@export var floatAmplitude: float = 5.0 
@export var floatSpeed: float = 2.0 
var smoothing_speed_y: float = .6
var smoothing_speed_x: float = 2.0
var p2_offset: float = 60  

var p1: Node2D

var _initial_position: Vector2 
var _time: float = 0.0         

const IDLE_ANIM : String = "Idle"
const BUBBLING : String = "Casting"

func _ready() -> void:
	if not p1:
		p1 = get_parent().get_node_or_null("playerScene") 
		if not p1:
			push_error("PlayerScene not found!")

	_initial_position = global_position
	#play(IDLE_ANIM)

func _physics_process(delta: float) -> void:
	if not p1:
		return  

	if Input.is_action_just_pressed("ui_undo"):
		
		cast_spell()
		


	_time += delta * floatSpeed
	var float_offset = sin(_time) * floatAmplitude
	var target_position_y = p1.global_position.y - 30 + float_offset
	var screen_size = get_viewport_rect().size  
	var sprite_half_width = 35

	var offset_sign = 1 if p1.global_position.x <= screen_size.x / 2 else -1
	var target_position_x = screen_size.x - p1.global_position.x + float_offset + (p2_offset * offset_sign)

	flip_h = (offset_sign == -1)

	target_position_x = clamp(target_position_x, sprite_half_width, screen_size.x - sprite_half_width)

	global_position.y = lerp(global_position.y, float(target_position_y), 1.0 - exp(-delta * smoothing_speed_y))
	global_position.x = lerp(global_position.x, float(target_position_x), 1.0 - exp(-delta * smoothing_speed_x))

func cast_spell():
	#bolha_aparece.play()
	play(BUBBLING)
	await get_tree().create_timer(0.7).timeout
	play(IDLE_ANIM)
