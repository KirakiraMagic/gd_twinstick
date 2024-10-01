extends State

var detect_range : Area2D
var chasing_state: State
@onready var sight_cast = $"../../RayCast2D"

func initialize():
	body.velocity = Vector2.ZERO
	detect_range = body.get_node("DetectionRange")
	chasing_state = body.get_node("States").get_node("Chasing")
	
func on_enter_state():
	$"../../AnimationTree".set("parameters/walk_idle/blend_amount", 0)

func process_state(delta: float):
	var potential_targets = detect_range.get_overlapping_bodies()
	if (not potential_targets.is_empty()):
		sight_cast.target_position = potential_targets[0].global_position-body.global_position
		if sight_cast.get_collider() == potential_targets[0]:
			chasing_state.target = potential_targets[0] as CharacterStateMachine
			change_state.emit(chasing_state)
		
