extends Control
@onready var label = $Label
@onready var texture = $TextureRect

var maxNum = 14
var pick = 0

var icon1 = load("res://assets/sprites/controlsIcon/IMG_1577.PNG")
var icon2 = load("res://assets/sprites/controlsIcon/IMG_1578.PNG")
var icon3 = load("res://assets/sprites/controlsIcon/IMG_1579.PNG")
var icon4 = load("res://assets/sprites/controlsIcon/IMG_1580.PNG")
var icon5 = load("res://assets/sprites/controlsIcon/IMG_1581.PNG")
var icon6 = load("res://assets/sprites/controlsIcon/IMG_1582.PNG")
var icon7 = load("res://assets/sprites/controlsIcon/IMG_1583.PNG")
var icon8 = load("res://assets/sprites/controlsIcon/IMG_1584.PNG")
var iconF = load("res://assets/sprites/controlsIcon/fIcon.PNG")
var iconEsc = load("res://assets/sprites/controlsIcon/escapeIcon.PNG")

func _process(delta):
	_label_set()
	_max_min()
	_icon_set()
	_control_layer_on()

func _icon_set():
	match[pick]:
		[0]:
			texture.set_texture(icon1)
		[1]:
			texture.set_texture(icon7)
		[2]:
			texture.set_texture(icon3)
		[3]:
			texture.set_texture(icon4)
		[4]:
			texture.set_texture(iconF)#F icon
		[5]:
			texture.set_texture(iconEsc)
		[6]:
			texture.set_texture(icon8)
		[7]:
			texture.set_texture(icon8)
		[8]:
			texture.set_texture(icon8)
		[9]:
			texture.set_texture(icon8)
		[10]:
			texture.set_texture(icon8)
		[11]:
			texture.set_texture(icon8)
		[12]:
			texture.set_texture(icon8)
		[13]:
			texture.set_texture(icon8)
		[14]:
			texture.set_texture(icon8)

func _label_set():
	match[pick]:
		[0]:
			label.set_text("Use the mouse to place blocks")
		[1]:
			label.set_text("The Blocks will change every press")
		[2]:
			label.set_text("Don't touch the red blocks they kill you")
		[3]:
			label.set_text("Touch the yellow blocks they give you points")
		[4]:
			label.set_text("press (F) to go full screen")
		[5]:#here
			label.set_text("press (P) to pause (in-game)")
		[6]:
			label.set_text("Look I am really tired")
		[7]:
			label.set_text("I ran out of time making this")
		[8]:
			label.set_text("It is literally 4am")
		[9]:
			label.set_text("I would show you a pic")
		[10]:
			label.set_text("But that would take more time")
		[11]:
			label.set_text("Why are you still reading this")
		[12]:
			label.set_text("I am just rambling")
		[13]:
			label.set_text("...")
		[14]:
			label.set_text("okay goodbye")

func _max_min():
	if pick <= 0:
		pick = 0
	if pick >= maxNum:# max
		pick = maxNum

func _on_left_button_pressed():
	pick -= 1

func _on_right_button_pressed():
	pick += 1


func _on_close_button_pressed():
	Globals.controlsScreenOn = false

func _control_layer_on():
	if Globals.controlsScreenOn == true:
		visible = true
	else:
		visible = false
