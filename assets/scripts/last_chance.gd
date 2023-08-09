extends Control

@onready var timer = $Timer
@onready var timeLeftBar = $timeLeftBar
@onready var animationPlayer = $AnimationPlayer
@onready var ad_button = $Control/TextureButton
@onready var ad_label = $Control/TextureButton/Label

var speicalTimer = false
var popUpValue = 100
var ad_wait_timer = Timer.new()


func _ready():
	if Globals.adIsLoaded == false:
		is_ad_loaded(false)
	_wait_for_ad()
	MobileAds.connect("rewarded_ad_loaded",Callable(self,"_on_MobileAds_rewarded_ad_loaded"))
	MobileAds.connect("rewarded_ad_closed",Callable(self,"_on_MobileAds_rewarded_ad_closed"))
	MobileAds.connect("user_earned_rewarded",Callable(self,"_on_MobileAds_user_earned_rewarded"))
	timeLeftBar.max_value = timer.get_wait_time() * popUpValue
	animationPlayer.play("bob")
	

func _wait_for_ad():
	ad_wait_timer.connect("timeout", wait_ad_done)
	ad_wait_timer.wait_time = .3
	ad_wait_timer.one_shot = true
	add_child(ad_wait_timer)
	ad_wait_timer.start()

func wait_ad_done():
	MobileAds.load_rewarded()
	print("ad should be loaded")
#	is_ad_loaded(true)

func _process(delta):
	_bar_progress()
	_lastChance_screen_on()
	_speicalTimer_start()
	_ad_button_disabled()

func _speicalTimer_start():
	if Globals.lastChanceScreenOn == true and speicalTimer == false:
		timer.start()
		speicalTimer = true
		

func is_ad_loaded(check):
	if check == true:
		ad_button.disabled = false
	if check == false:
		ad_button.disabled = true

func _ad_button_disabled():
	if ad_button.disabled == true:
		ad_button.self_modulate = "383838"
		ad_label.modulate.a = 0.3
	elif ad_button.disabled == false:
		ad_button.self_modulate = "639bff"
		ad_label.modulate.a = 1


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

func _on_MobileAds_rewarded_ad_loaded() -> void:
	is_ad_loaded(true)
	Globals.adIsLoaded = true
	print(" ad is loaded fully :) ")


func _on_MobileAds_rewarded_ad_closed() -> void:
	Globals.adIsLoaded = false
	is_ad_loaded(false)
#	MobileAds.load_rewarded()

func _on_texture_button_button_down():#put ad logic here and give last chance
	is_ad_loaded(false)
	MobileAds.show_rewarded()

func _on_MobileAds_user_earned_rewarded(currency : String, amount : int) -> void:
	_continue()

func _on_skip_button_pressed():
	timeLeftBar.visible = false
	ad_button.disabled = true
	animationPlayer.play("shrinkOut")

func _on_timer_timeout():
	ad_button.disabled = true
	animationPlayer.play("shrinkOut")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shrinkOut":
		_go_away()



