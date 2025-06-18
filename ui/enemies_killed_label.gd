extends Label


func _ready() -> void:
	SignalBus.enemy_killed.connect(_on_enemy_killed)


func _on_enemy_killed() -> void:
	text = "ENEMIES KILLED: " + str(GameManager.enemies_killed)
