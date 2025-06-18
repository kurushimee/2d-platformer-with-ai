extends EnemyState


@export var chase_speed := 75.0


func fixed_update(_delta: float) -> void:
	if get_distance_to_player() > enemy.chase_radius:
		transitioned.emit(self, &"patrol")
		return

	var direction := signf(player.global_position.x - enemy.global_position.x)
	if can_move_in_direction(direction):
		enemy.velocity.x = direction * chase_speed
	else:
		enemy.velocity.x = 0.0

	enemy.move_and_slide()

	try_chase()
