extends CharacterBody2D

const PROJECTILE_SPEED = 500
var forward = Vector2.ZERO

func _physics_process(delta):
	#Bouncy ball code
	velocity = forward * PROJECTILE_SPEED * delta
	var collision = move_and_collide(velocity)
	if collision:
		forward = velocity.bounce(collision.get_normal()).normalized()
		if collision.get_collider().is_in_group("shield"):
			queue_free()
		if collision.get_collider().has_method("hit"):
			GlobalAudioManager.play_sfx("res://metallic-clap_90bpm_D_minor.wav")
			collision.get_collider().hit(1)
			queue_free()

func _on_timer_timeout():
	self.queue_free()
