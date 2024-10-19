extends Weapon

@onready var sword = $Sword

func on_pickup():
	if holder.is_in_group("player"):
		sword.set_collision_mask_value(1, false)
		sword.set_collision_mask_value(2, true)
	elif holder.is_in_group("enemy"):
		sword.set_collision_mask_value(1, true)
		sword.set_collision_mask_value(2, false)

func attack(target_position : Vector2):
	if attacking:
		return true
	attacking = true
	var tween = create_tween()
	tween.tween_property(sword, "rotation", sword.rotation + 2 * PI, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.play()
	await tween.finished
	if is_instance_valid(holder):
		if holder.is_in_group("player"):
			durability -= 1
	attacking = false
	emit_signal("attack_complete")
	return true
		
func _on_sword_body_entered(body:Node2D):
	if body.has_method("hit"):
		body.hit(1)

func on_drop():
	sword.set_collision_mask_value(1, false)
	sword.set_collision_mask_value(2, true)
