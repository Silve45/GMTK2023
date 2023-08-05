extends VBoxContainer
@export var buttonNum = 0 
@export var scoreNeeded = 0
var unlocked = false

@onready var ballLabel = $Label
@onready var ball = $ColorRect/ball
@onready var button = $ColorRect/Button
@onready var warningLabel = $ColorRect/ball/warningLabel

#check if the color is being used and check if score is enough
func _process(delta):
	_button_on()
	_unlocked()
	_warning_label_on()

func _unlocked():
	if scoreNeeded > Globals.bestScore:
		unlocked = false
	elif scoreNeeded <= Globals.bestScore:
		unlocked = true

func _button_on():
	if unlocked == true:
		if Globals.ballColorNum == buttonNum:
			button.disabled = true
			button.text = "selected"
		else:
			button.disabled = false
			button.text = "select"
	else:
		var string = str("reach ", str(scoreNeeded))
		button.disabled = true
		button.text = string

func _warning_label_on():
	if buttonNum == 11:
		warningLabel.visible = true
	else:
		warningLabel.visible = false

#get the balls color and set it
func _ready():
	_label_and_color(buttonNum)

func _label_and_color(num):
	match[num]:
		[0]:
			ballLabel.set_text("is zero... change plz")
			_set_ball_color(Globals._ball_color(buttonNum))
		[1]:
			ballLabel.set_text("White")
			_set_ball_color(Globals._ball_color(buttonNum))
		[2]:
			ballLabel.set_text("Orange")
			_set_ball_color(Globals._ball_color(buttonNum))
		[3]:
			ballLabel.set_text("Pink")
			_set_ball_color(Globals._ball_color(buttonNum))
		[4]:
			ballLabel.set_text("Light Blue")
			_set_ball_color(Globals._ball_color(buttonNum))
		[5]:
			ballLabel.set_text("Brown")
			_set_ball_color(Globals._ball_color(buttonNum))
		[6]:
			ballLabel.set_text("Yellow")
			_set_ball_color(Globals._ball_color(buttonNum))
		[7]:
			ballLabel.set_text("Dark Blue")
			_set_ball_color(Globals._ball_color(buttonNum))
		[8]:
			ballLabel.set_text("Green")
			_set_ball_color(Globals._ball_color(buttonNum))
		[9]:
			ballLabel.set_text("Purple")
			_set_ball_color(Globals._ball_color(buttonNum))
		[10]:
			ballLabel.set_text("Red")
			_set_ball_color(Globals._ball_color(buttonNum))
		[11]:
			ballLabel.set_text("Rainbow")
			_set_ball_color("ffffff")

func _set_ball_color(color):
	ball.modulate = color

#set ballNum for everything --> debug you still need to save it
func _on_button_pressed():
	_set_ball_num(buttonNum)
	
func _set_ball_num(num):
	Globals.ballColorNum = num

