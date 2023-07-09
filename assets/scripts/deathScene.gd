extends Control
@onready var scoreLabel = $labelContainer/scoreLabel
@onready var bestScoreLabel = $labelContainer/bestScoreLabel

func _process(delta):
	_final_score()
	_death_layer_on()

func _final_score():
	var str = str("Score is ", int(Globals.score))
	scoreLabel.set_text(str)
	
	var str2 = str("Best Score is ", int(Globals.bestScore))
	bestScoreLabel.set_text(str2)

func _death_layer_on():
	if Globals.dead == true:
		visible = true
	else:
		visible = false

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_game_button_pressed():
	get_tree().quit()
