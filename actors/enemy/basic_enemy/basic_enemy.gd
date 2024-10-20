extends CharacterStateMachine
class_name Enemy

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var detection_area : Area2D = $DetectionArea
@onready var sight_cast : RayCast2D= $SightCast
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D
@export var weapon : Weapon
@onready var heart = preload("res://heart.tscn")

@export var chase_distance := 30.0
@export var chase_speed := 20.0
@export var attack_frequency := 1.0

@export var hp := 3

func initiate():
	if weapon:
		weapon.holder = self

func hit(damage_taken: int):
	hp -= damage_taken
	if hp <= 0:
		var random_drop = randi_range(1, 2)
		print( "random drop: "+str(random_drop))
		if random_drop == 1:
			print("drop heart")
			var new_heart = heart.instantiate()
			new_heart.global_position = global_position
			get_parent().add_child(new_heart)
		if weapon:
			await weapon.drop()
			queue_free()
		else:
			queue_free()
