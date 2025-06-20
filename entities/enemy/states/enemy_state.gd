class_name EnemyState
extends Node

signal transitioned(state: EnemyState, new_state_name: StringName)

@onready var enemy: Enemy = get_owner()
var player: Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	enemy.damaged.connect(_on_enemy_damaged)


func enter() -> void:
	pass


func update(_delta: float) -> void:
	pass


func fixed_update(_delta: float) -> void:
	pass


func exit() -> void:
	pass


###############################################
# Non FSM-specific methods. These are utility
# methods that may be used by multiple states.
###############################################


func can_move_in_direction(direction: float) -> bool:
	enemy.switch_direction(direction)
	return not enemy.wall_check_cast.is_colliding() and enemy.ground_check_cast.is_colliding()


# Attempts to switch to chase state if it detects the player
func try_chase() -> bool:
	if player.is_dead:
		return false

	if can_see_player() and get_distance_to_player() <= enemy.detection_radius:
		transitioned.emit(self, &"chase")
		return true

	return false


# RayCast from Enemy to the Player to see if there are any obstacles in the way
func can_see_player() -> bool:
	enemy.player_check_cast.target_position = player.global_position - enemy.player_check_cast.global_position
	return not enemy.player_check_cast.is_colliding()


func get_distance_to_player() -> float:
	return player.global_position.distance_to(enemy.global_position)


func _on_enemy_damaged() -> void:
	transitioned.emit(self, &"stun")
