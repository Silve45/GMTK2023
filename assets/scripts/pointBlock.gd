extends Node2D

@onready var collisionShape = $StaticBody2D/CollisionShape2D
@onready var hurtAreaShape = $hurtArea/CollisionShape2D
@onready var onTimer = $onTimer
@onready var awayTimer = $awayTimer
@onready var deadTimer = $deadTimer
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
	goAwayTime = 3
	print(goAwayTime)
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
	hurtAreaShape.disabled = true
	sprite.modulate = "f7c75631"
	collisionShape.disabled = true
	onTimer.start()

func _placed():
	hurtAreaShape.disabled = false
	animationPlayer.play("blockOn")
	sprite.modulate = "f7c756"
	collisionShape.disabled = false
	timerSwitch = true

func _destroyed():
	Globals.score += 10
	sprite.visible = false
	label.visible = false
	hurtAreaShape.call_deferred("set_disabled", true)
	collisionShape.call_deferred("set_disabled", true)
	particles.emitting = true
	particles.one_shot = true
	deadTimer.start()

func _gone():
	queue_free() #add animation here

func _on_on_timer_timeout():
	_placed()
	awayTimer.start()


func _on_away_timer_timeout():
	#start like this now may remove it _debug
	collisionShape.disabled = true
	animationPlayer.play("blockOut")


func _on_hurt_area_body_entered(body):
	_destroyed()


func _on_dead_timer_timeout():
	queue_free()
