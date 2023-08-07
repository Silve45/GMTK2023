extends Node

const save_file = "user://save.data"

var score = int(0)
var bestScore = int(0)
var dead = false
var maxHurtBlockCount = 3
var controlsScreenOn = false
var fullScreen = false
var creditsScreenOn = false
var storeScreenOn = false
var lastChanceScreenOn = false
var oneLastChance = false
var deathScreenOn = false
var spawnNewBallScreenOn = false #yes another one...

#stuff for store
#var ballColor = ""
var ballColorNum = 1 #default color
var incrementColorNum = 1
var timerColor = "ffffff"
@onready var changeColorTimer = $changeColorTimer

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
			ballColor = "e64e35"#lighter red
		[11]:
			ballColor = timerColor
	return ballColor

func _ready():
	changeColorTimer.start()
	_load()

func _on_change_color_timer_timeout():
	var finalColor
	if incrementColorNum < 11:
		if incrementColorNum < 10:
			incrementColorNum += 1
		elif incrementColorNum == 10:
			incrementColorNum = 1
			
	finalColor = _ball_color(incrementColorNum)
	timerColor = finalColor

func _reset():
	score = 0
	maxHurtBlockCount = 3
	dead = false
	controlsScreenOn = false
	deathScreenOn = false
	lastChanceScreenOn = false
	oneLastChance = false
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

#save things
func _save():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	var player_data = create_player_data()
	file.store_var(player_data)
	file.close()#me

func _load():
	var file = FileAccess.open(save_file, FileAccess.READ)
	if FileAccess.file_exists(save_file):
		var loaded_player_data = file.get_var()
		bestScore = loaded_player_data.HIGHSCORE
		ballColorNum = loaded_player_data.BALLCOLOR
		MusicController.musicOn = loaded_player_data.MUSICON
		MusicController.sfxOn = loaded_player_data.SFXON
		file.close()
	else:
		_save()

func create_player_data():
	var player_dict = {
		"HIGHSCORE" : bestScore,
		"BALLCOLOR" : ballColorNum,
		"MUSICON" : MusicController.musicOn,
		"SFXON" : MusicController.sfxOn
	}
	return player_dict
