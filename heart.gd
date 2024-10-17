extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body:Node2D):
	if body.is_in_group("player"):
		if body.health < body.max_health:
			body.health += 1
			Global.player_health_changed.emit(body.health)
			queue_free()
	pass # Replace with function body.
