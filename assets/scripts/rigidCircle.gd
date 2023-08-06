extends RigidBody2D
@export_group("speed")
@export var xVelocity = 200
@export var yVelocity = 200
@export var set_begin_speed = 1.0

@onready var sprite = $Sprite2D
@onready var particles = $CPUParticles2D
@onready var deathTimer = $CPUParticles2D/deathTimer
@onready var soundEffect = $AudioStreamPlayer

signal sendSpeed

var velocity = Vector2()
var speed

var maxVelocity = null 
var minVelocity = null

#var maxVelocity = Vector2(200, 200)

func _ready():
	speed = set_begin_speed
	deathTimer.set_wait_time(particles.get_lifetime())
	velocity = Vector2(xVelocity ,yVelocity)


func _process(delta):
	_speed_up()
	_set_ball_color()

#sets the balls color
func _set_ball_color():
	sprite.modulate = Globals._ball_color(Globals.ballColorNum)

func _physics_process(delta):
	_movementStuff(delta )


func _movementStuff(delta):
	var collision_info = move_and_collide(velocity * delta * speed)
	if collision_info: 
		velocity = velocity.bounce(collision_info.get_normal())
		

func _on_hurt_box_body_entered(body):
	_dead()
	print("dead")

func _on_hurt_box_area_entered(area):
	pass # Replace with function body.

func _dead():
	#sound effect here
	var deathSound = load("res://assets/soundEffects/breakSoundEffect.wav")
	soundEffect.stream = deathSound
	soundEffect.play()
	$"../../gameCamera"._apply_shake(100, 10)
	particles.emitting = true
	particles.one_shot = true
	sprite.visible = false
	velocity = Vector2.ZERO
	Globals.dead = true#sets dead here *changed
#	Globals.deathScreenOn = true
#	Globals.lastChanceScreenOn = true
	_dead_or_last_chance()
	deathTimer.start()#frees it
	Globals._save()

#	if OS.get_name() == "Windows" || OS.get_name() == "macOS":
#		_controller(event, 1)
#	if OS.get_name() == "Android" || OS.get_name() == "iOS":
#		_controller(event, 2)

func _dead_or_last_chance():
	if Globals.oneLastChance == false:
		Globals.lastChanceScreenOn = true
	else:
		Globals.deathScreenOn = true
		#debug change this back to bottom code at end
#	if OS.get_name() == "Android"|| OS.get_name() == "iOS":
#		if Globals.oneLastChance == false:
#			Globals.lastChanceScreenOn = true
#		else:
#			Globals.deathScreenOn = true
#	else:
#		Globals.deathScreenOn = true

func _on_death_timer_timeout():
	queue_free()
	#death thing here


func _bounceSound():
	var bounceSound = load("res://assets/soundEffects/ballHitOffBlock.wav")
	soundEffect.stream = bounceSound
	soundEffect.play()
	$"../../gameCamera"._apply_shake(0,0)

func _on_sound_box_body_entered(body):
	_bounceSound()

var one = false
var two = false 
var three = false
var four = false
var five = false
var six = false
var seven = false
var eight = false
func _speed_up():
	if Globals.score >= 25 and one == false:
		emit_signal("sendSpeed")
		one = true
		speed = 1.05
	elif Globals.score >= 50 and two == false:
		emit_signal("sendSpeed")
		two = true
		speed = 1.1
	elif Globals.score >= 100 and three == false:
		emit_signal("sendSpeed")
		three = true
		speed = 1.15
	elif Globals.score >= 150 and four == false:
		emit_signal("sendSpeed")
		four = true
		speed = 1.2
	elif Globals.score >= 175 and five == false:
		emit_signal("sendSpeed")
		five = true
		speed = 1.25
	elif Globals.score >= 200 and six == false:
		emit_signal("sendSpeed")
		six = true
		speed = 1.3
	elif Globals.score >= 250 and seven == false:
		emit_signal("sendSpeed")
		seven = true
		speed = 1.35
	elif Globals.score >= 300 and eight == false:
		emit_signal("sendSpeed")
		eight = true
		speed = 1.4
