extends Area2D

const PROJECTILE_SPEED = 100
var forward = Vector2.ZERO

func _physics_process(delta):
	position += forward * PROJECTILE_SPEED * delta


func _on_timer_timeout():
	self.queue_free()
	pass # Replace with function body.

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.hit(1)
		queue_free()
	if body.is_in_group("terrain") or body.is_in_group("shield"):
		queue_free()
	pass
