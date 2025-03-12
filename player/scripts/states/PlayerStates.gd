class_name PlayerState extends State

const IDLE = "PlayerIdle"
const MOVING = "PlayerMove"
const FALLING = "PlayerFall"
const STUNNED = "PlayerStunned" 

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "")
