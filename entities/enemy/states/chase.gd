extends EnemyState


@export var chase_speed := 75.0


func enter() -> void:
	enemy.play_anim(&"default")


func fixed_update(_delta: float) -> void:
	var distance := get_distance_to_player()
	if player.is_dead or not can_see_player() or distance > enemy.chase_radius:
		transitioned.emit(self, &"patrol")
		return
	elif distance <= enemy.attack_radius:
		transitioned.emit(self, &"attack")
		return

	var delta_to_player := player.global_position.x - enemy.global_position.x
	var direction := signf(delta_to_player)
	if not (delta_to_player > -10.0 and delta_to_player < 10.0) and can_move_in_direction(direction):
		enemy.velocity.x = direction * chase_speed
	else:
		enemy.velocity.x = 0.0

	enemy.move_and_slide()
