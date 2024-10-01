extends State

@export var chase_speed := 50.0
var target : CharacterStateMachine

func process_state(delta):
	if body.position.distance_to(target.position) > 60.0:
		body.velocity = (target.position - body.position).normalized() * chase_speed
		$"../../Shield".look_at(target.position)
		body.move_and_slide()
