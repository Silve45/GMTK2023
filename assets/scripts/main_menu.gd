extends Control
@onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("beginningAnimation")


func _on_play_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_quit_game_button_pressed():
	get_tree().quit()


func _on_controls_button_pressed():
	Globals.controlsScreenOn = true
