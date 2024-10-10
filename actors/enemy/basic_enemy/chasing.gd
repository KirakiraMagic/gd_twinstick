extends State

@onready var projectile = preload("res://enemy_projectile.tscn")

@export var idle_state: State
@export var attack_state: State

var time_since_attack := 0.0

var target : CharacterStateMachine
var last_target_position := Vector2.ZERO
var chase_timeout := 0.0

func initialize():
	if not idle_state:
		idle_state = $"../Idle"
	if not attack_state:
		attack_state = $"../Attack"

func on_enter_state() -> void:
	body.animation_tree.set("parameters/walk_idle/blend_amount", 1)

func on_exit_state() -> void:
	pass

func process_state(delta) -> void:
	body.sight_cast.target_position = target.global_position-body.global_position

	if body.sight_cast.get_collider() != target:
		chase_timeout += delta
		if chase_timeout > 5.0:
			change_state.emit(idle_state)
	else:
		last_target_position = target.global_position
		chase_timeout = 0.0
		time_since_attack += delta
		if time_since_attack > body.attack_frequency:
			time_since_attack = 0.0
			attack_state.target = target
			change_state.emit(attack_state)

	if body.position.distance_to(last_target_position) > body.chase_distance:
		body.velocity = body.global_position.direction_to(last_target_position) * body.chase_speed
		body.animation_tree.set("parameters/Direction/blend_position", body.velocity.normalized())
		body.move_and_slide()

func shoot_bullet(fire_direction : Vector2):
	var bullet = projectile.instantiate()
	bullet.forward = fire_direction
	bullet.global_position = body.global_position
	get_parent().add_child(bullet)
	pass
