extends Node

@onready var music = $AudioStreamPlayer
var musicOn = true
var sfxOn = true
#songs 
var song = load("res://assets/music/plug-156524.mp3")
var beginningSong = load("res://assets/music/game-music-loop-19-153393.mp3")

func _process(delta): 
	_mute_SFX()
	_mute_music()

func _play_song(pickedSong): #this may not work - fix if it doesn't
	match[pickedSong]:
		[1]: 
			music.stream = song
			music.volume_db = -10# made it quieter
		[2]:
			music.stream = beginningSong
			music.volume_db = 0
	music.play()



func _mute_music():
	var master_sound = AudioServer.get_bus_index("Music")
	if musicOn == true:
		AudioServer.set_bus_mute(master_sound, false)
	elif musicOn == false:
		AudioServer.set_bus_mute(master_sound, true)

func _mute_SFX():
	var sfx_sound = AudioServer.get_bus_index("SFX")
	if sfxOn == true:
		AudioServer.set_bus_mute(sfx_sound, false)
	if sfxOn == false:
		AudioServer.set_bus_mute(sfx_sound, true)

func _stop_music():
	music.stop()
