extends State

@export var chasing_state: State

var target: Node2D

func initialize() -> void:
	if not chasing_state:
		chasing_state = $"../Chasing"

func on_enter_state() -> void:
	if body.weapon:
		await body.weapon.attack(target.global_position)
	change_state.emit(chasing_state)

func on_exit_state() -> void:
	pass

func process_state(delta: float) -> void:
	pass
