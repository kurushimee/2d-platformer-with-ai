class_name AttackComponent
extends Node2D

@export var damage: int = 1

## Minimum delay between attacks in seconds.
@export var cooldown: float = 1.0

## Attack distance in pixels.
@export var reach: float = 50.0

@onready var raycast: RayCast2D = $RayCast2D

@onready var cooldown_timer: float = cooldown


func _process(delta: float) -> void:
	if cooldown_timer < cooldown_timer:
		cooldown_timer += delta


func attack(direction: Vector2) -> void:
	if cooldown_timer < cooldown: return

	raycast.target_position = direction.normalized() * reach

	if raycast.is_colliding():
		var coll := raycast.get_collider() as HealthComponent

		if coll is HealthComponent:
			coll.take_damage(damage)
			cooldown_timer = 0.0
