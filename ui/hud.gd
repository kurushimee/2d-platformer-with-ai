extends CanvasLayer

@onready var game_over_label: Label = $GameOverLabel


func show_game_over() -> void:
	game_over_label.show()
