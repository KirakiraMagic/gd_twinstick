extends Area2D

@export var max_lifetime := 3.0
var lifetime := 0.0

const PROJECTILE_SPEED = 300
var forward = Vector2.ZERO

func _physics_process(delta):
	lifetime += delta
	if lifetime > max_lifetime:
		queue_free()
		return
	position += forward * PROJECTILE_SPEED * delta

func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit(1)
		GlobalAudioManager.play_sfx("res://metallic-clap_90bpm_D_minor.wav")
		queue_free()
	if body.is_in_group("terrain") or body.is_in_group("shield"):
		queue_free()
	pass
