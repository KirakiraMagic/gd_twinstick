extends Weapon

@onready var projectile = preload("res://actors/enemy/tomes/projectile.tscn")
@onready var bullet_spawn_point = $BulletSpawnPosition

func attack(target_position) -> bool:
	attacking = true
	var fire_direction = bullet_spawn_point.global_position.direction_to(target_position)
	var bullet = projectile.instantiate()
	bullet.forward = fire_direction
	bullet.global_position = bullet_spawn_point.global_position

	if is_instance_valid(holder):
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
	emit_signal("attack_complete")
	return true
