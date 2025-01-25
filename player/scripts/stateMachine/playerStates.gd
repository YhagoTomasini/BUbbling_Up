class_name PlayerState extends State

const IDLE = "PlayerIdle"
const WALKING = "PlayerWalk"
const JUMPING = "PlayerJump"

var player: PlayerCharacter

func _ready() -> void:
	await owner.ready
	player = owner as PlayerCharacter
	assert(player != null, "")
