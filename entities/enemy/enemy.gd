class_name Enemy
extends CharacterBody2D

signal damaged

@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
@export var attack_radius := 25.0

@export_group("Nodes")
@export var animated_sprite: AnimatedSprite2D
@export var check_casts: Node2D


func switch_direction(direction: float) -> void:
	animated_sprite.flip_h = direction < 0.0
	check_casts.scale.x = direction


func play_anim(anim: StringName) -> void:
	animated_sprite.play(anim)
	await animated_sprite.animation_finished


func _on_health_component_taken_damage() -> void:
	damaged.emit()


func _on_health_component_died() -> void:
	await animated_sprite.animation_finished
	queue_free()
