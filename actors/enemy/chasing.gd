extends State

@export var chase_speed := 50.0
var target : CharacterStateMachine

func process_state(delta):
	if body.position.distance_to(target.position) > 30.0:
		body.velocity = (target.position - body.position).normalized() * chase_speed
		body.move_and_slide()
