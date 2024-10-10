extends State

@export var chasing_state: State

@onready var projectile = preload("res://enemy_projectile.tscn")

var target: Node2D

func initialize() -> void:
	if not chasing_state:
		chasing_state = $"../Chasing"

func on_enter_state() -> void:
	shoot_bullet(body.global_position.direction_to(target.global_position))
	change_state.emit(chasing_state)

func on_exit_state() -> void:
	pass

func process_state(delta: float) -> void:
	pass

func shoot_bullet(fire_direction : Vector2) -> void:
	var bullet = projectile.instantiate()
	bullet.forward = fire_direction
	bullet.global_position = body.global_position
	get_parent().add_child(bullet)

