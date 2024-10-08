extends CharacterBody2D
class_name CharacterStateMachine

@export var initial_state : State

var all_states : Array[State]
var current_state : State

func _ready() -> void:
	current_state = initial_state
	for child in $States.get_children():
		if child is State:
			all_states.append(child)
			child.change_state.connect(change_state)
			child.body = self
			child.initialize()
		else:
			push_warning("Child " + child.name + " is not a state for " + self.name)
	initialize()
	
## Replaces ready function in child classes of CharacterStateMachine, called after states are initialized
func initialize():
	pass

func change_state(next_state : State) -> void:
	current_state.on_exit_state()
	current_state = next_state
	current_state.on_enter_state()
	
func _physics_process(delta) -> void:
	current_state.process_state(delta)