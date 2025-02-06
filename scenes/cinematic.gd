extends Node2D

@onready var grito_da_aguia: AudioStreamPlayer = $grito_da_aguia
@onready var asas_batendo: AudioStreamPlayer = $asas_batendo
@onready var mae_gritando: AudioStreamPlayer = $mae_gritando


@onready var eagle = $Eagle
@onready var mom = $Mommy
@onready var p1 = $playerCharacter
@onready var p2 = $player2

@export var speed: float = 150.0
var target_position: Vector2 = Vector2.ZERO

var captured : bool = false

func _ready() -> void:
	grito_da_aguia.play()
	asas_batendo.play()
	eagle.play("default")
	mom.play("Idle")
	target_position = mom.position
	
	await get_tree().create_timer(4).timeout
	
	jogo()

func _process(delta: float) -> void:
	move_eagle(delta)

func move_eagle(delta: float) -> void:
	if eagle.position.distance_to(target_position) > 1.0:
		eagle.position = eagle.position.move_toward(target_position, speed * delta)
	else:
		if target_position == mom.position:
			mae_gritando.play()
			mom.play("Captured")
			target_position = get_next_point()  # Obtenha o próximo ponto
			captured = true
	if captured:
		mom.position = eagle.position + Vector2(6, 20)

func get_next_point() -> Vector2:
	return Vector2(-100, -300)  # Exemplo de ponto fixo

func jogo():
	get_tree().change_scene_to_file("res://level/level.tscn")
