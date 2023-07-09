extends Node

@onready var music = $AudioStreamPlayer

#songs 
var song = load("")

func _play_song(pickedSong): #this may not work - fix if it doesn't
	match[pickedSong]:
		[1]: 
			music.stream = song
#			music.volume_db = -10# made it quieter
	music.play()

func _stop_music():
	music.stop()
