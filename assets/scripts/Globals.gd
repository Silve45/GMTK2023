extends Node

var score = int(0)
var newScore = int(0)
var bestScore = int(0)
var dead = false
var maxHurtBlockCount = 3
var controlsScreenOn = false
var fullScreen = false
var creditsScreenOn = false

func _reset():
	score = 0
	newScore = 0
	maxHurtBlockCount = 3
	dead = false
	controlsScreenOn = false
	get_tree().paused = false

func _process(delta):
	_best_score()
	_fullScreen()

func _best_score():
	if score >= bestScore:
		bestScore = score


func _fullScreen():
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if fullScreen == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullScreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullScreen = false
