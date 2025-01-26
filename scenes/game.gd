extends Node2D

@export var bubble_scene: PackedScene

var current_bubbles: Array = []
var max_bubbles: int = 3

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_bubble(event.position)

func spawn_bubble(position: Vector2) -> void:
	# Check if the number of bubbles has reached the limit
	if current_bubbles.size() >= max_bubbles:
		return

	# Instantiate the bubble
	var bubble = bubble_scene.instantiate()
	add_child(bubble)
	bubble.position = position

	# Add the bubble to the tracking array
	current_bubbles.append(bubble)

	# Connect the bubble's "tree_exited" signal to remove it from the array when it gets freed
	bubble.connect("tree_exited", Callable(self, "_on_bubble_removed"))

func _on_bubble_removed(node: Node) -> void:
	if node in current_bubbles:
		current_bubbles.erase(node)
