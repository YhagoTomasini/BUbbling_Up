extends AnimatedSprite2D

@export var floatAmplitude: float = 5.0 
@export var floatSpeed: float = 2.0 

@onready var p1 = $".."

var _initial_position: Vector2 
var _time: float = 0.0         

const IDLE_ANIM : String =  "Idle"
const BUBBLING : String = "Casting"

func _ready() -> void:
	_initial_position = global_position
	
	play(IDLE_ANIM)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_undo"):
		cast_spell()
	
	_time += delta * floatSpeed
	var float_offset = sin(_time) * floatAmplitude
	global_position.y = _initial_position.y + float_offset 
	global_position.x = _initial_position.x + float_offset 

func cast_spell():
	play(BUBBLING)
	await get_tree().create_timer(0.7).timeout
	play("Idle")
