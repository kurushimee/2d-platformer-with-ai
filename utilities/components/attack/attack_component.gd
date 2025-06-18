class_name AttackComponent
extends Area2D

@export var damage: int = 1

## Minimum delay between attacks in seconds.
@export var cooldown: float = 1.0

## Attack distance in pixels.
@export var reach: float = 50.0

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var cooldown_timer: float = cooldown


func _process(delta: float) -> void:
	if cooldown_timer < cooldown:
		cooldown_timer += delta


func attack() -> void:
	if cooldown_timer < cooldown: return

	collision_shape.shape.radius = reach
	if not has_overlapping_bodies(): return

	for body in get_overlapping_bodies():
		# Avoids attacking self if the owner is an Entity
		if body == owner:
			continue

		# Applies damage to the first Entity within reach
		for child in body.get_children():
			if child is HealthComponent:
				child.take_damage(damage)
				cooldown_timer = 0.0
				return
