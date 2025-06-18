extends EnemyState


@export var chase_speed := 75.0


func enter() -> void:
	enemy.play_anim(&"default")


func fixed_update(_delta: float) -> void:
	var distance := get_distance_to_player()
	if distance > enemy.chase_radius:
		transitioned.emit(self, &"patrol")
		return
	elif distance <= enemy.attack_radius:
		transitioned.emit(self, &"attack")
		return

	var direction := signf(player.global_position.x - enemy.global_position.x)
	if can_move_in_direction(direction):
		enemy.velocity.x = direction * chase_speed
	else:
		enemy.velocity.x = 0.0

	enemy.move_and_slide()
