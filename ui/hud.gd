extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_health_changed.connect(_on_player_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

## Updates player health text on HUD
func _on_player_health_changed(new_health: int) -> void:
	$Health.text = "Health: " + "♥".repeat(new_health)