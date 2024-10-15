extends Weapon

@export var charge_time = 0.5
@onready var projectile = preload("res://actors/enemy/tomes/bouncy_projectile.tscn")
@onready var bullet_spawn_point = $BulletSpawnPosition
@onready var charge_particles = $BulletSpawnPosition/ChargeParticles

func attack(target_position) -> bool:
	if attacking:
		return true
	
	attacking = true
	#Charge the bullet
	charge_particles.emitting = true
	await get_tree().create_timer(charge_time).timeout
	charge_particles.emitting = false
	var fire_direction = bullet_spawn_point.global_position.direction_to(target_position)
	var bullet = projectile.instantiate()
	bullet.forward = fire_direction
	bullet.global_position = bullet_spawn_point.global_position
	if holder.is_in_group("player"):
		bullet.set_collision_mask_value(1, false)
		bullet.set_collision_mask_value(2, true)
	elif holder.is_in_group("enemy"):
		bullet.set_collision_mask_value(1, true)
		bullet.set_collision_mask_value(2, false)
	holder.get_parent().add_child(bullet)
	if holder.is_in_group("player"):
		durability -= 1
	attacking = false
	return true
