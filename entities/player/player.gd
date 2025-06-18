class_name Player
extends CharacterBody2D

signal player_died

const SPEED = 300.0
const JUMP_VELOCITY = -625.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_component: AttackComponent = $AttackComponent

var direction: float = 0.0


func _process(_delta: float) -> void:
	direction = Input.get_axis(&"move_left", &"move_right")

	# Aim the sprite in movement direction
	if not is_zero_approx(direction):
		animated_sprite.flip_h = direction < 0.0

	# Play animations
	if is_on_floor():
		if direction == 0.0:
			animated_sprite.play(&"idle")
		else:
			animated_sprite.play(&"run")
	else:
		animated_sprite.play(&"jump")


func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle the movement/deceleration
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_released(&"jump"):
		# Halt jump if input ends abruptly
		if velocity.y < 0.0:
			velocity.y *= 0.5
	elif event.is_action_pressed(&"attack"):
		attack_component.attack()


func _on_health_component_taken_damage() -> void:
	animated_sprite.play(&"hit")


func _on_health_component_died() -> void:
	animated_sprite.play(&"die")
	player_died.emit()
