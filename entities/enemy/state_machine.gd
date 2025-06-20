extends Node


@export var initial_state: EnemyState

var current_state: EnemyState
var states: Dictionary[StringName, EnemyState] = {}


func _ready() -> void:
	for child in get_children():
		if child is EnemyState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transitioned)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.fixed_update(delta)


func _on_child_transitioned(state: EnemyState, new_state_name: StringName) -> void:
	if state != current_state:
		return

	var new_state := states[new_state_name.to_lower()]
	if not new_state:
		return

	# Clean up the previous state
	if current_state:
		current_state.exit()

	# Initialize the new state
	new_state.enter()
	current_state = new_state
