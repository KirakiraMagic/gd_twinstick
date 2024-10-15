extends Area2D


func _on_body_entered(body:Node2D):
	Global.checkpoint_pos = body.global_position
	pass # Replace with function body.
