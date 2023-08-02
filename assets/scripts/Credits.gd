extends Control

func _process(delta):
	_credits_layer_on()

func _credits_layer_on():
	if Globals.creditsScreenOn == true:
		visible = true
	else:
		visible = false

func _on_quit_game_button_pressed():
	Globals.creditsScreenOn = false

func _on_button_pressed():
	OS.shell_open("https://pixabay.com/music/video-games-game-music-loop-19-153393/")


func _on_button_2_pressed():
	OS.shell_open("https://pixabay.com/music/beats-plug-156524/")





func _on_privacy_button_pressed():
	OS.shell_open("https://shinystarsgames.squarespace.com/privacy-policy?p")


func _on_credits_button_pressed():
	OS.shell_open("https://shinystarsgames.squarespace.com/credits-yatw?p")
