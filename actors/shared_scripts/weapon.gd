extends Node3D
class_name Weapon

signal attack_complete()

@export var durrability := 5

var holder : CharacterStateMachine

func drop():
	pass

func pick_up():
	pass

func attack(target_position : Vector2):
	pass