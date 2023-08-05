extends Node

var score = int(0)
var newScore = int(0)
var bestScore = int(0)
var dead = false
var maxHurtBlockCount = 3
var controlsScreenOn = false
var fullScreen = false
var creditsScreenOn = false

#stuff for store
#var ballColor = ""
var ballColorNum = 0

func _ball_color(ballNum):
	var ballColor
	match[ballNum]:
		[0]:
			ballColor = "ffffff"#white
		[1]:
			ballColor = "ffffff"#white
		[2]:
			ballColor = "e67a30"#orange
		[3]:
			ballColor = "f873e4"#pink
		[4]:
			ballColor = "4dcced"#light blue
		[5]:
			ballColor = "a86437"#brown
		[6]:
			ballColor = "f7c756"#yellow
		[7]:
			ballColor = "306082"#darker blue
		[8]:
			ballColor = "99e550"#lighter green
		[9]:
			ballColor = "d151ee"#purple
		[10]:
			ballColor = "f25a5a"#lighter red
	return ballColor

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
