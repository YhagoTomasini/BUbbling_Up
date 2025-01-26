extends Node2D

@export var bubble_scene: PackedScene

var current_bubbles: Array = []
var max_bubbles: int = 3

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var world_position = get_global_mouse_position()
		spawn_bubble(world_position)
		print(current_bubbles)

func spawn_bubble(position: Vector2) -> void:
	if current_bubbles.size() >= max_bubbles:
		var oldest_bubble = current_bubbles[0] 
		if is_instance_valid(oldest_bubble):
			oldest_bubble.queue_free() 
		current_bubbles.remove_at(0) 

	var bubble = bubble_scene.instantiate()
	add_child(bubble)
	bubble.position = position

	current_bubbles.append(bubble)

	bubble.connect("tree_exited", Callable(self, "_on_bubble_removed"))

func _on_bubble_removed(node: Node) -> void:
	if node in current_bubbles:
		current_bubbles.erase(node)
