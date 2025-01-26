extends Node2D

@export var bubble_scene: PackedScene

@export var timerPlacer1: Timer
@export var timerPlacer2: Timer
@export var timerPlacer3: Timer

var current_bubbles: Array = []
var max_bubbles: int = 3
var canPlace1: bool = true
var canPlace2: bool = true
var canPlace3: bool = true

func _ready() -> void:
	if timerPlacer1 and timerPlacer2 and timerPlacer3:
		timerPlacer1.connect("timeout", Callable(self, "_on_timer_placer1_timeout"))
		timerPlacer2.connect("timeout", Callable(self, "_on_timer_placer2_timeout"))
		timerPlacer3.connect("timeout", Callable(self, "_on_timer_placer3_timeout"))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var world_position = get_global_mouse_position()
		spawn_bubble(world_position)

func spawn_bubble(position: Vector2) -> void:
	if canPlace1:
		place_bubble(position)
		canPlace1 = false
		timerPlacer1.start()
	elif canPlace2:
		place_bubble(position)
		canPlace2 = false
		timerPlacer2.start()
	elif canPlace3:
		place_bubble(position)
		canPlace3 = false
		timerPlacer3.start()

func place_bubble(position: Vector2) -> void:
	if current_bubbles.size() >= max_bubbles:
		var oldest_bubble = current_bubbles[0]
		if is_instance_valid(oldest_bubble):
			oldest_bubble.queue_free()
		current_bubbles.remove_at(0)

	var bubble = bubble_scene.instantiate()
	add_child(bubble)
	bubble.position = position
	current_bubbles.append(bubble)

func _on_timer_placer1_timeout() -> void:
	canPlace1 = true

func _on_timer_placer2_timeout() -> void:
	canPlace2 = true

func _on_timer_placer3_timeout() -> void:
	canPlace3 = true
