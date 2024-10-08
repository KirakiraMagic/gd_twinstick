extends AudioStreamPlayer

var current_track_name : String = ""


var current_music_track : AudioStream

func play_track(new_stream: AudioStream, volume : float = 1.0):
	if stream == new_stream:
		return
	
	stream = new_stream
	volume_db = volume
	play()

func play_sfx(new_steam: AudioStream, volume := 1.0):
	var sfx_player = AudioStreamPlayer2D.new()
	sfx_player.stream = new_steam
	sfx_player.volume_db = volume
	add_child(sfx_player)
	sfx_player.play()
	await sfx_player.finished
	sfx_player.queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
