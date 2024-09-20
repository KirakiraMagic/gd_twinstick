extends CharacterStateMachine

@onready var projectile = preload("res://projectile.tscn")
@onready var bouncy_fruit = preload("res://bouncy.tscn")
@onready var explosive_projectile = preload("res://exploding_projectile.tscn")
@onready var projectile_spawn_point = $BulletSpawnPoint
@onready var animation_player = $AnimationPlayer
@export var move_speed : float = 60.0


func _physics_process(delta):
	if Input.is_action_just_pressed("fire_normal"):
		shoot_bullet(projectile)	
	if Input.is_action_just_pressed("fire_bouncy"):
		shoot_bullet(bouncy_fruit)
	if Input.is_action_just_pressed("fire_explosive"):
		shoot_bullet(explosive_projectile)


	velocity = Input.get_vector("move_left", "move_right","move_up", "move_down") * move_speed
	move_and_slide()

	var angle = rad_to_deg(velocity.angle()) + 180
	print(angle)

	if velocity.length() < 10.0:
		animation_player.play("idle_front")
	else:
		if angle > 135.0 and angle < 225.0:
			animation_player.play("walk_right")
		elif angle > 225.0 and angle < 315.0:
			animation_player.play("walk_front")
		elif angle > 315.0 or angle < 45.0:
			animation_player.play("walk_left")
		elif angle > 45.0 and angle < 135.0:
			animation_player.play("walk_back")

func shoot_bullet(bullet_scene):
	var bullet = bullet_scene.instantiate()
	bullet.forward = position.direction_to(get_global_mouse_position())
	bullet.position = projectile_spawn_point.global_position
	get_parent().add_child(bullet)
	pass