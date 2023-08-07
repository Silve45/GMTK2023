extends Control

@onready var timer = $Timer
@onready var label = $Label

func _process(delta):
	_spawn_ball_screen_on()
	_set_label()

func _spawn_ball_screen_on():
	if Globals.spawnNewBallScreenOn == true:
		visible = true
	else:
		visible = false

func _set_label():
	var string = int(timer.get_time_left())
	label.set_text(str(string))
