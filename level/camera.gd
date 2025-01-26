extends Camera2D

var target_position = Vector2.ZERO
var smoothing_speed = 10.0
var shake_threshold = 2.0 

func _ready() -> void:
	make_current()

func _process(delta: float) -> void:
	acquire_target()
	# Adjust only the Y-axis of the global_position
	if abs(global_position.y - target_position.y) > shake_threshold:
		global_position.y = lerp(global_position.y, target_position.y, 1.0 - exp(-delta * smoothing_speed))

func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position
		
# bruh
