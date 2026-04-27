extends AudioStreamPlayer
func play_music(new_stream: AudioStream) -> void:
	if stream == new_stream:
		return # Already playing this song
	stream = new_stream
	play()
