extends State

var detect_range: Area2D
var idle_state: State
@export var chase_speed := 20.0
@export var chase_distance := 30.0
@onready var projectile = preload("res://enemy_projectile.tscn")
var shield : Node2D
var sword : Node2D
var is_chasing := false

var target : CharacterStateMachine
@onready var sight_cast = $"../../RayCast2D"

func initialize():
	detect_range = body.get_node("DetectionRange")
	idle_state = body.get_node("States").get_node("Idle")
	shield =body.get_node("Shield")
	sword = body.get_node("Sword")
	
	
func on_enter_state():
	is_chasing = true
	$"../../AnimationTree".set("parameters/walk_idle/blend_amount", 1)

func on_exit_state():
	is_chasing = false
	
	
func process_state(delta):
	sight_cast.target_position = target.global_position-body.global_position
	
	if sight_cast.get_collider() != target:
		change_state.emit(idle_state)
	
	if body.position.distance_to(target.position) > chase_distance:
		body.velocity = (target.position - body.position).normalized() * chase_speed
		$"../../AnimationTree".set("parameters/Direction/blend_position", body.velocity.normalized())
		body.move_and_slide()
	
	if shield != null:
		shield.look_at(target.global_position)

	if sword != null:
		sword.rotation_degrees += delta * 200


func _on_fire_timer_timeout():
	if is_chasing and sword == null:
		shoot_bullet((target.position - body.position).normalized())
	pass # Replace with function body.

func shoot_bullet(fire_direction : Vector2):
	var bullet = projectile.instantiate()
	bullet.forward = fire_direction
	bullet.global_position = body.global_position
	get_parent().add_child(bullet)
	pass
