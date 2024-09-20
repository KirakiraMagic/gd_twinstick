extends State

var detect_range : Area2D
var chasing_state: State

func initialize():
	detect_range = body.get_node("DetectionRange")
	chasing_state = body.get_node("States").get_node("Chasing")

func process_state(delta: float):
	var potential_targets = detect_range.get_overlapping_bodies()
	if (not potential_targets.is_empty()):
		print(potential_targets)
		chasing_state.target = potential_targets[0] as CharacterStateMachine
		change_state.emit(chasing_state)
