extends Node2D
@onready var collisionShape = $StaticBody2D/CollisionShape2D
@onready var onTimer = $onTimer
@onready var awayTimer = $awayTimer
@onready var sprite = $StaticBody2D/Sprite2D
@onready var animationPlayer = $AnimationPlayer
@onready var particles = $CPUParticles2D
@onready var label = $Label
var screenSize = null 
var goAwayTime
var timerSwitch = false

func _get_random_position():
	screenSize = get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0, screenSize.x)
	var rndY = rng.randi_range(0, screenSize.y)
	
	position.x = rndX
	position.y = rndY
	
	var rng2 = RandomNumberGenerator.new()
	goAwayTime = rng2.randi_range(2, 5)
#	print(goAwayTime)
	awayTimer.wait_time = goAwayTime
	animationPlayer.play("blockIn")

func _ready():
	_get_random_position()
	_not_placed()

func _process(delta):
	_setTimer()

func _setTimer():
	if timerSwitch == false:
		label.set_text(str(int(onTimer.time_left)))
	else:
		label.set_text(str(int(awayTimer.time_left)))

func _not_placed():
	sprite.modulate = "e64e3527"
	collisionShape.disabled = true
	onTimer.start()

func _placed():
	animationPlayer.play("blockOn")
	particles.emitting = true
	particles.one_shot = true
	sprite.modulate = "e64e35"
	collisionShape.disabled = false
	timerSwitch = true

func _gone():
	queue_free() #add animation here

func _on_on_timer_timeout():
	_placed()
	awayTimer.start()


func _on_away_timer_timeout():
	#start like this now may remove it _debug
	collisionShape.disabled = true
	animationPlayer.play("blockOut")

