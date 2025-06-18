extends EnemyState

@export var patrol_speed: float = 50.0


func enter() -> void:
	enemy.velocity.x = patrol_speed


func fixed_update(_delta: float) -> void:
	if not can_move_in_direction(signf(enemy.velocity.x)):
		enemy.velocity.x *= -1.0

	enemy.move_and_slide()

	try_chase()
