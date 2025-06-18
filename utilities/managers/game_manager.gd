extends Node

var enemies_killed: int = 0


func _ready() -> void:
	SignalBus.enemy_killed.connect(_on_enemy_killed)


func _on_enemy_killed() -> void:
	enemies_killed += 1
