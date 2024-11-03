extends AudioStreamPlayer


const levelMusic = preload("res://Audio/Happy sounds.mp3")

func _playMusic(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func _playMusicLevel():
	_playMusic(levelMusic)
	
func _stopMusic(music: AudioStream, volume = 0.0):
	stop()

func _stopMusicLevel():
	_stopMusic(levelMusic)
	
