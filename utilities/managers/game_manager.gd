extends Node

var enemies_killed: int = 0
var is_game_over: bool = false


func _ready() -> void:
	SignalBus.enemy_killed.connect(_on_enemy_killed)
	get_tree().get_first_node_in_group("player").player_died.connect(_on_player_died)


func _input(event: InputEvent) -> void:
	if event.is_pressed() and is_game_over:
		restart()


func restart() -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_enemy_killed() -> void:
	enemies_killed += 1


func _on_player_died() -> void:
	is_game_over = true
