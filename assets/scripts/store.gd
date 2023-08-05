extends Control

@onready var scrollContainer = $ScrollContainer

func _ready():
	_hide_scroll_bar()

#hides the scroll bar
func _hide_scroll_bar():
	scrollContainer.get_h_scroll_bar().modulate = Color(0, 0, 0, 0)
	scrollContainer.get_h_scroll_bar().scale.x = 0 
	scrollContainer.get_h_scroll_bar().scale.y = 0 

func _process(delta):
	_store_layer_on()

func _store_layer_on():
	if Globals.storeScreenOn == true:
		visible = true
	else:
		visible = false


func _on_play_pressed():
	Globals.storeScreenOn = false
