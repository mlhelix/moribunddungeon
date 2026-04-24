extends AudioStreamPlayer

func play_music(stream: AudioStreamMP3):
	stream.loop = true
	self.stream
	self.play()
	
func stop_music():
	self.stop
