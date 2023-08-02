extends Control
@onready var muteMusic = $MuteButtons/MuteMusic
@onready var muteSFX = $MuteButtons/MuteSfx


func _ready():
	pass
#	get_tree().paused = true

func _process(delta):
	_pause_layer_on()
	_pause()
	_button_change()
#	_hide_quit()


func _pause_layer_on():#I had a old way in godot 3,but this is cooler
	var isPaused = get_tree().is_paused()
	if isPaused == true:
		visible = true
	else:
		visible = false

func _pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true

func _on_resume_game_button_pressed():
	get_tree().paused = false

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_game_button_pressed():
	get_tree().paused = false
	get_tree().quit()


func _on_mute_music_pressed():
	if MusicController.musicOn == false:
		MusicController.musicOn = true
	else:
		MusicController.musicOn = false


func _on_mute_sfx_pressed():
	if MusicController.sfxOn == false:
		MusicController.sfxOn = true
	else:
		MusicController.sfxOn = false

func _button_change():
	if MusicController.musicOn == true:
		muteMusic.set_text("Mute Music")
	else:
		muteMusic.set_text("Unmute Music")
	
	if MusicController.sfxOn == true:
		muteSFX.set_text("Mute SFX")
	else:
		muteSFX.set_text("Unmute SFX")
