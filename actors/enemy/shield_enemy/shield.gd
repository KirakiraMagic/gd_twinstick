extends StaticBody2D

@onready var chasing_state = $"../States/Chasing"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chasing_state.last_target_position != Vector2.ZERO:
		look_at(chasing_state.last_target_position)
	pass
