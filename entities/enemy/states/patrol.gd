extends EnemyState

@export var ground_check_cast: RayCast2D

@export var patrol_speed: float = 50.0


func enter() -> void:
	enemy.velocity.x = patrol_speed


func fixed_update(_delta: float) -> void:
	# Change direction if can't go any further
	if enemy.is_on_wall() or not ground_check_cast.is_colliding():
		enemy.velocity.x *= -1.0
		enemy.scale.x *= -1.0

	enemy.move_and_slide()
