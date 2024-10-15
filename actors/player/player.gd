extends CharacterStateMachine

@onready var animation_player = $AnimationPlayer
@export var move_speed : float = 60.0

@export var weapon : Weapon

@export var dodge_speed := 300.0
@export var dodge_duration := 0.1

var is_dodging := false
var dodge_timer := 0.0
var dodge_direction := Vector2.ZERO

@export var health : int = 5

func _ready():
	pass

func _physics_process(delta):

	var direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	velocity = direction
	if velocity.length() > 1.0:
		velocity = velocity.normalized()
	velocity = velocity * move_speed

	if Input.is_action_just_pressed("dodge_roll"):
		is_dodging = true
		dodge_timer = 0
		dodge_direction = direction

	if is_dodging:
		dodge_timer += delta
		velocity = dodge_direction * dodge_speed
		if dodge_timer >= dodge_duration:
			is_dodging = false
			dodge_timer = 0

	var aim_direction = position.direction_to(get_global_mouse_position())
	if weapon:
		if not weapon.attacking: 
			weapon.global_rotation = aim_direction.angle()
	
	if Input.is_action_just_pressed("fire_normal"):
		if weapon:
			await weapon.attack(get_global_mouse_position())
			print(weapon.durability <= 0) #I have no idea why but this print statement fixes the logic
			if weapon.durability <= 0:
				weapon.queue_free()
				weapon = null

	move_and_slide()
	
	var angle = rad_to_deg(velocity.angle()) + 180

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

func hit(damage : int):
	if is_dodging:
		return
	health -= damage
	Global.player_health_changed.emit(health)
	if health <= 0:
		GlobalAudioManager.stop()
		GlobalAudioManager.play_sfx("res://death_sfx.mp3", 1.0)
		Global.on_player_death.emit()
