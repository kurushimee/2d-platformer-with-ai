class_name Enemy
extends CharacterBody2D

@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
@export var attack_radius := 25.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var check_casts: Node2D = $CheckCasts


func switch_direction(direction: float) -> void:
	animated_sprite.flip_h = direction < 0.0
	check_casts.scale.x = direction
