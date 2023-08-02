extends Control
@onready var animationPlayer = $AnimationPlayer
@onready var muteButtons = $MuteButtons
@onready var muteMusic = $MuteButtons/MuteMusic
@onready var muteSFX = $MuteButtons/MuteSfx
@onready var soundEffect = $AudioStreamPlayer

func _ready():
	MusicController._play_song(2)
	muteButtons.visible = false
	animationPlayer.play("beginningAnimation")


func _on_play_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _explode_sound():
	var sound = load("res://assets/soundEffects/breakSoundEffect.wav")
	soundEffect.stream = sound
	soundEffect.play()

func _on_quit_game_button_pressed():
	get_tree().quit()


func _on_controls_button_pressed():
	Globals.controlsScreenOn = true


func _on_credits_button_pressed():
	Globals.creditsScreenOn = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "beginningAnimation":
		muteButtons.visible = true


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

func _process(delta):
	_hide_quit()
	_button_change()

func _button_change():
	if MusicController.musicOn == true:
		muteMusic.set_text("Mute Music")
	else:
		muteMusic.set_text("Unmute Music")
	
	if MusicController.sfxOn == true:
		muteSFX.set_text("Mute SFX")
	else:
		muteSFX.set_text("Unmute SFX")

func _hide_quit():
	if (OS.get_name() == "web"):
		$ColorRect/VBoxContainer/quitGameButton.visible = false
	else:
		pass
