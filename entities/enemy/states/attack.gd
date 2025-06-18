extends EnemyState

@export var attack_component: AttackComponent


func enter() -> void:
	await enemy.play_anim(&"attack")
	attack_component.attack()
	transitioned.emit(self, &"chase")
