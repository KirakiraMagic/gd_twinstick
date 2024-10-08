extends State

@export var chasing_state: State

func initialize() -> void:
	body.velocity = Vector2.ZERO
	
	if not chasing_state:
		chasing_state = body.get_node("States").get_node("Chasing")
	
func on_enter_state() -> void:
	body.animation_tree.set("parameters/walk_idle/blend_amount", 0)

func process_state(_delta: float) -> void:
	var potential_targets = body.detection_area.get_overlapping_bodies()
	if (not potential_targets.is_empty()):
		body.sight_cast.target_position = potential_targets[0].global_position-body.global_position
		if body.sight_cast.get_collider() == potential_targets[0]:
			chasing_state.target = potential_targets[0] as CharacterStateMachine
			change_state.emit(chasing_state)
