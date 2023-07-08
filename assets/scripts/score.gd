extends Control

@onready var label = $Label
@onready var timer = $Timer

func _process(delta):
#	Globals.score += 1 * delta#debug, needs 1
	var score = int(Globals.score)
	
	if score < 10000:
		label.set_text(str(score))
	elif score >= 10000:
		label.set_text(">9999")
	_is_dead()

func _on_timer_timeout():
	Globals.score += 1

func _is_dead():
	if Globals.dead == true:
		timer.stop()
