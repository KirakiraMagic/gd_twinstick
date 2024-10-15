extends Area2D
class_name Weapon

signal attack_complete

@export var durability := 5
@export var follow_distance := 50.0
@export var evade_distance := -1.0


var attacking = false
var holder : CharacterStateMachine

func _ready():
	connect("body_entered", on_weapon_body_entered)
	if (get_parent() is CharacterStateMachine) and (not holder):
		pick_up(get_parent())

func on_weapon_body_entered(body : Node2D):
	if not holder:
		if body is CharacterStateMachine:
			if body.weapon == null:
				pick_up(body)

func drop() -> bool:
	holder.remove_child(self) 
	holder.get_parent().add_child(self)
	holder.weapon = null
	global_position = holder.global_position
	on_drop()
	return true

func pick_up(body : CharacterStateMachine):
	holder = body
	if get_parent() != body:
		get_parent().remove_child(self)
		holder.add_child(self)
	global_position = holder.global_position
	holder.weapon = self
	on_pickup()

func on_pickup():
	pass

func on_drop():
	pass

func attack(target_position : Vector2) -> bool:
	return true
