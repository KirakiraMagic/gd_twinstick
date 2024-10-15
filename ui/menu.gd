extends Control

@onready var game_name_text = $VBoxContainer/GameNameText
@onready var death_text = $VBoxContainer/DeathText
@onready var start_button = $VBoxContainer/StartButton
@onready var resume_button = $VBoxContainer/ResumeButton
@onready var restart_button = $VBoxContainer/RestartButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var respawn_button = $VBoxContainer/RespawnButton

func _process(delta):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _ready():
	Global.on_player_death.connect(death)
	pause()

func start():
	var audio_stream = load("res://CRAZY Instrumental.mp3") as AudioStream
	GlobalAudioManager.play_track(audio_stream, 1.0)
	resume()

func pause():
	visible = true
	get_tree().paused = true

func resume():
	restart_button.visible = true
	resume_button.visible = true
	start_button.visible = false
	get_tree().paused = false
	visible = false

func quit():
	get_tree().quit()

func restart():
	Global.checkpoint_pos = Vector2.ZERO
	get_tree().reload_current_scene()

func death():
	pause()
	death_text.visible = true
	game_name_text.visible = false
	restart_button.visible = true
	if Global.checkpoint_pos != Vector2.ZERO:
		respawn_button.visible = true
	resume_button.visible = false
	start_button.visible = false


func _on_respawn_button_pressed():
	get_tree().reload_current_scene()
