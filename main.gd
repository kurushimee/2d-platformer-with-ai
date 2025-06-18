extends Node

@onready var hud: CanvasLayer = $HUD

var is_game_over: bool = false


func _input(event: InputEvent) -> void:
	if event.is_pressed() and is_game_over:
		restart()


func restart() -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_player_died() -> void:
	is_game_over = true
	hud.show_game_over()
