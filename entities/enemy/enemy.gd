class_name Enemy
extends CharacterBody2D

signal damaged

@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
@export var attack_radius := 25.0

@export_group("Nodes")
@export var animated_sprite: AnimatedSprite2D
@export var wall_check_cast: RayCast2D
@export var ground_check_cast: RayCast2D
@export var player_check_cast : RayCast2D


func switch_direction(direction: float) -> void:
	animated_sprite.flip_h = direction < 0.0
	wall_check_cast.target_position.x = direction * absf(wall_check_cast.target_position.x)
	ground_check_cast.position.x = direction * absf(ground_check_cast.position.x)


func play_anim(anim: StringName) -> void:
	animated_sprite.play(anim)
	await animated_sprite.animation_finished


func _on_health_component_taken_damage() -> void:
	damaged.emit()


func _on_health_component_died() -> void:
	SignalBus.enemy_killed.emit()
	await animated_sprite.animation_finished
	queue_free()
