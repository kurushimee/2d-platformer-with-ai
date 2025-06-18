extends CanvasLayer

@onready var game_over_label: Label = $GameOverLabel


func _on_player_died() -> void:
	game_over_label.show()
