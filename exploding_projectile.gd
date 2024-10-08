extends Area2D

@onready var projectile = preload("res://projectile.tscn")
const PROJECTILE_SPEED = 200
var forward = Vector2.ZERO

func _physics_process(delta):
	position += forward * PROJECTILE_SPEED * delta


func _on_timer_timeout():
	#Spawn new projectiles in a circle
	var direction = Vector2.LEFT
	for i in range(10):
		shoot_projectile(direction)
		direction = direction.rotated(2.0 * PI / 10.0)
	self.queue_free()

func shoot_projectile(direction : Vector2):
	var new_projectile = projectile.instantiate()
	new_projectile.position = position
	new_projectile.forward = direction
	get_parent().add_child(new_projectile)

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hit(1)
		queue_free()
	if body.is_in_group("terrain") or body.is_in_group("shield"):
		queue_free()
	pass
