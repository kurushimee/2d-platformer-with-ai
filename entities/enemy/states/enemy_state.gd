class_name EnemyState
extends Node

signal transitioned(state: EnemyState, new_state_name: StringName)

@onready var enemy: Enemy = get_owner()
var player: Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


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


# Attempts to switch to chase state if it detects the player
func try_chase() -> bool:
	if get_distance_to_player() <= enemy.detection_radius:
		transitioned.emit(self, &"chase")
		return true

	return false


func get_distance_to_player() -> float:
	return player.global_position.distance_to(enemy.global_position)
