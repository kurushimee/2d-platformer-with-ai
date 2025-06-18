extends Area2D


# Immediately kill the entity upon colliding
func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is HealthComponent:
			child.take_damage(child.max_health)
