extends Control

@onready var timer = $Timer
@onready var timeLeftBar = $timeLeftBar
@onready var animationPlayer = $AnimationPlayer
@onready var button = $Control/TextureButton

var speicalTimer = false
var popUpValue = 100

func _ready():
	timeLeftBar.max_value = timer.get_wait_time() * popUpValue
	animationPlayer.play("bob")
	

func _process(delta):
	_bar_progress()
	_lastChance_screen_on()
	_speicalTimer_start()

func _speicalTimer_start():
	if Globals.lastChanceScreenOn == true and speicalTimer == false:
		timer.start()
		speicalTimer = true
		

func _bar_progress():
	timeLeftBar.value = timer.get_time_left() * popUpValue

func _lastChance_screen_on():
	if Globals.lastChanceScreenOn == true and Globals.oneLastChance == false:
		visible = true
	else:
		visible = false

func _go_away():
	Globals.lastChanceScreenOn = false
	Globals.deathScreenOn = true
	Globals.oneLastChance = true
	timer.stop()

func _continue():#other stuff here as well
	Globals.oneLastChance = true
	Globals.lastChanceScreenOn = false
	Globals.spawnNewBallScreenOn = true
	$"../spawnNewBall/Timer".start()
	timer.stop()

func _on_texture_button_button_down():#put ad logic here and give last chance
	_continue()


func _on_skip_button_pressed():
	timeLeftBar.visible = false
	button.disabled = true
	animationPlayer.play("shrinkOut")

func _on_timer_timeout():
	button.disabled = true
	animationPlayer.play("shrinkOut")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shrinkOut":
		_go_away()



