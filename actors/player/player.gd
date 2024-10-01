extends CharacterStateMachine

@onready var projectile = preload("res://projectile.tscn")
@onready var bouncy_fruit = preload("res://bouncy.tscn")
@onready var explosive_projectile = preload("res://exploding_projectile.tscn")
@onready var weapon = $Weapon
@onready var projectile_spawn_point = $Weapon/BulletSpawnPoint
@onready var animation_player = $AnimationPlayer
@export var move_speed : float = 60.0

@export var health : int = 5

func _ready():
	$HUD/Health.text = "Health: " + "♥".repeat(health)

func _physics_process(delta):

	var aim_direction = position.direction_to(get_global_mouse_position())
	weapon.global_rotation = aim_direction.angle()

	if Input.is_action_just_pressed("fire_normal"):
		shoot_bullet(projectile, aim_direction)	
	if Input.is_action_just_pressed("fire_bouncy"):
		shoot_bullet(bouncy_fruit, aim_direction)
	if Input.is_action_just_pressed("fire_explosive"):
		shoot_bullet(explosive_projectile, aim_direction)


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

func shoot_bullet(bullet_scene, fire_direction : Vector2):
	var bullet = bullet_scene.instantiate()
	bullet.forward = fire_direction
	bullet.position = projectile_spawn_point.global_position
	get_parent().add_child(bullet)
	pass

func hit(damage : int):
	health -= damage
	$HUD/Health.text = "Health: " + "♥".repeat(health)
	if health <= 0:
		print("YOU LOSE")
		$HUD/Health.text = "You're Dead!"
