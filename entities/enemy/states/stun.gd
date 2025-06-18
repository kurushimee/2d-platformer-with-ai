extends EnemyState


func enter() -> void:
	await enemy.play_anim(&"stun")
	transitioned.emit(self, &"chase")


func exit() -> void:
	enemy.play_anim(&"default")
