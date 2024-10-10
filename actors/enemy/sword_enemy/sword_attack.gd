extends State

@export var chasing_state: State
@export var sword : Node2D

var target: Node2D

func initialize() -> void:
	if not chasing_state:
		chasing_state = $"../Chasing"
	if not sword:
		sword = body.get_node("Sword")

func on_enter_state() -> void:
	swing_sword()
	change_state.emit(chasing_state)

func on_exit_state() -> void:
	pass

func process_state(delta: float) -> void:
	pass

#tween the sword in a circle
func swing_sword() -> void:
	var tween = create_tween()
	tween.tween_property(sword, "rotation", sword.rotation + 2 * PI, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.play()