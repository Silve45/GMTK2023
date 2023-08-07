extends CharacterBody2D

@export var speed = 200

@onready var animationPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var mainSprite = $Sprite2D
@onready var label = $Label

var deathNum = 0
var startMoving = false
var timerOn = false

func _ready():
#	$ball_detect_move/CollisionShape2D.disabled = false
	label.set_text(str(int(timer.wait_time)))
	$arrow.modulate = "e64e3527"
	mainSprite.modulate = "e64e3527"
	animationPlayer.play("begin")
	label.visible = true


func _move():
	velocity = transform.x * speed

func _rotate_ball():
	rotation_degrees -= 90

func _physics_process(delta):
	if startMoving == true and deathNum != 4:
		_move()
		move_and_slide()

func _process(delta): 
	_number_to_death()
	_set_timer()
	_if_is_dead()

func _on_ball_detect_move_body_entered(body):
	_rotate_ball()
	deathNum += 1
	print(str(deathNum))

func _number_to_death():
	if deathNum == 4:
		_dead()

func _dead():
	animationPlayer.play("end")

func _if_is_dead():
	if Globals.dead == true:
		_dead()
	else:
		pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "begin":
		timer.start()
		timerOn = true
	if anim_name == "end":
		queue_free()


func _on_timer_timeout():
		mainSprite.modulate = "e64e35"
		label.visible = false
		startMoving = true
		animationPlayer.play("spin")

func _set_timer():
	if timerOn == true:
		label.set_text(str(int(timer.time_left)))
