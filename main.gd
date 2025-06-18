extends Node


func _on_player_died() -> void:
	get_tree().reload_current_scene()
