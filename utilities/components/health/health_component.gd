class_name HealthComponent
extends Node2D

signal taken_damage
signal died

@onready var label: Label = $Label

@export var max_health: int = 10
var health_points: int:
	set(value):
		health_points = value
		label.text = str(clampi(health_points, 0, max_health), " HP")


func _ready() -> void:
	health_points = max_health


func take_damage(amount: int) -> void:
	if health_points <= 0: return

	health_points -= amount
	taken_damage.emit()

	if health_points <= 0:
		died.emit()
