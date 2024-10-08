extends CharacterStateMachine
class_name Enemy

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var detection_area : Area2D = $DetectionArea
@onready var sight_cast : RayCast2D= $SightCast
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D

@export var hp := 3

func hit(damage_taken: int):
	hp -= damage_taken
	if hp <= 0:
		queue_free()