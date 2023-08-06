extends Control

#the label is -1 on z
#and the speed up label is +2 on z

@onready var label = $Label
@onready var timer = $Timer
@onready var animationPlayer = $AnimationPlayer
@onready var sfx = $AudioStreamPlayer

func _ready():
	animationPlayer.play("RESET")
	$"../playerHolder/rigidCircle".connect("sendSpeed", _speed_up)

func _process(delta):
	var score = int(Globals.score)
	
	if score < 10000:
		label.set_text(str(score))
	elif score >= 10000:
		label.set_text(">9999")
	_is_dead()
#	_speed_up()

func _on_timer_timeout():
	Globals.score += 1

func _is_dead():
	if Globals.dead == true:
		timer.set_paused(true)
	else:
		timer.set_paused(false)

func _speed_up():#signal plays this
	animationPlayer.play("labelFull")

func _play_sound():
	sfx.play()

